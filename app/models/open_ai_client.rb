class OpenAiClient
  include ActionView::Helpers::SanitizeHelper

  def initialize
    @client = ::OpenAI::Client.new(access_token: Rails.application.credentials.dig(:openai_secret))
  end

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

  def get_speech(text)
    response = @client.audio.speech(
      parameters: {
        model: 'tts-1',
        input: process_email_for_upload(text),
        voice: 'onyx',
      }
    )

    File.binwrite(Rails.root.join("tmp/storage/news-#{Time.now.strftime('%F')}.mp3"), response)
  end

  def clean_content(content)
    if content.include? '```HTML'
      content.slice!('```HTML')
    end
    if content.include? '```'
      content.slice!('```')
    end

    content
  end

  def process_email_for_upload(text)
    content = Nokogiri.HTML4(DailyMailerPreview.new.daily_email(text).body.to_s).css('div.container').to_s
    strip_links(content)
  end
end
