# Wrapper for OpenAI client use
class OpenAiClient
  include ActionView::Helpers::SanitizeHelper

  # @return [OpenAiClient]
  def initialize
    @client = ::OpenAI::Client.new(access_token: Rails.application.credentials.dig(:openai_secret))
  end

  # Queries OpenAI API GPT-4 model to summarize daily news
  # @return [String]
  def get_text(query)
    response = @client.chat(parameters: {
      model: "gpt-4", # Required.
      messages: [
        {
          role: 'system',
          content: 'You are a Alfred Pennyworth, the Wayne family butler. You provide daily news summaries and always end them with a haiku summarizing the daily events.'
        },
        { role: 'user', content: query}
      ], # Required.
      temperature: 0.7
    })

    clean_content response.dig('choices', 0, 'message', 'content')
  end

  # Queries OpenAI API Whisper model to create audio summary of daily news, and saves to S3
  # @return [String] filename of local file
  def get_speech(text)
    response = @client.audio.speech(
      parameters: {
        model: 'tts-1',
        input: text,
        voice: 'onyx',
      }
    )

    filename = "tmp/storage/news-#{Time.now.strftime('%F')}.mp3"
    File.binwrite(Rails.root.join(filename), response)
    PutToS3Job.perform_later(tmp_path: filename)

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
end
