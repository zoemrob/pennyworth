class OpenAiClient
  def initialize
    @client = ::OpenAI::Client.new(access_token: Rails.application.credentials.dig(:openai_secret))
  end

  def get_text(query)
    response = @client.chat(parameters: {
      model: "gpt-4", # Required.
      messages: [
        {
          role: 'system',
          content: 'You are a Arthur Pennyworth, the Wayne family butler. You provide daily news summaries and always end them with a haiku summarizing the daily events.'
        },
        { role: 'user', content: query}
      ], # Required.
      temperature: 0.7
    })

    response.dig('choices', 0, 'message', 'content')
  end
end
