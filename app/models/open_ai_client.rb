# Wrapper for OpenAI client use
class OpenAiClient
  include ActionView::Helpers::SanitizeHelper

  attr_reader :client

  TMP_STORAGE = 'tmp/storage'

  # @return [OpenAiClient]
  def initialize
    @client = ::OpenAI::Client.new(access_token: Rails.application.credentials.dig(:openai_secret))
  end

  # Queries OpenAI API GPT-4 model to summarize daily news
  # @param prompt [Prompt]
  # @return [String]
  def get_text(prompt)
    response = @client.chat(parameters: {
      model: prompt.model_name, # Required.
      messages: [
        {
          role: 'system',
          content: 'You are a sophisticated butler to an important hero. You always provide me with the most important daily news, so I can serve my world best.'
        },
        { role: 'user', content: prompt.template}
      ], # Required.
      temperature: 0.7
    })

    clean_content response.dig('choices', 0, 'message', 'content')
  end

  # Queries OpenAI API Whisper model to create audio summary of daily news, and saves to S3
  # @param text [String] text to get speech
  # @param time [DateTime] time for file
  #
  # @return [String] filename of local file
  def get_speech(text, time)
    response = @client.audio.speech(
      parameters: {
        model: 'tts-1',
        input: text,
        voice: 'onyx',
      }
    )

    filename = get_filename(time)
    filepath = TMP_STORAGE + '/' + filename

    File.binwrite(Rails.root.join(filepath), response)
    PutToS3Job.perform_later(tmp_path: filepath)

    filename
  end

  # Cleans from variance in GPT-4 response sometimes containing backticks
  # @return [String]
  def clean_content(content)
    if content.include? '```HTML'
      content.slice!('```HTML')
    end
    if content.include? '```'
      content.slice!('```')
    end

    content
  end

  # Makes sure to get a unique filename not on S3
  # @param time [DateTime] for file timestamp naming
  def get_filename(time)
    fn = 'news-'
    fn << time.strftime('%F')
    fn << '.mp3'

    s3 = S3Client.new

    i = 2
    fn_n = fn
    while s3.file_exists? fn_n,  ENV['AUDIO_S3_BUCKET'] do
      fn_n = fn.split('.').join("_#{i}.")
      i += 1
    end

    fn_n
  end
end
