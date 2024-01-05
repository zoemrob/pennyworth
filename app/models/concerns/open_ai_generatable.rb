# Module pertaining to OpenAI GPT-4 and Whisper generation
module OpenAiGeneratable
  # Generates text from OpenAI
  # @return [String] formatted news summary
  def generate_text(prompt)
    OpenAiClient.new.get_text(prompt)
  end

  # Generates audio from OpenAI
  # @return [String] filename
  def generate_audio(content)
    OpenAiClient.new.get_speech(content, created_at)
  end
end


