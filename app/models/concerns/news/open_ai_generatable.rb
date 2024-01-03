# Module pertaining to OpenAI GPT-4 and Whisper generation
module News::OpenAiGeneratable
  # Generates text from OpenAI
  # @return [String] formatted news summary
  def generate_text
    OpenAiClient.new.get_text(summary.template)
  end

  # Generates audio from OpenAI
  # @return [String] filename
  def generate_audio
    OpenAiClient.new.get_speech(News::StrippedContent.new(body).to_s)
  end

  # Generates the news for today, including audio
  # @return [self]
  def generate_todays_news!
    generate_todays_text!
    generate_todays_audio!

    self
  end

  # Generates the news for today
  def generate_todays_text!
    update_column(:body, generate_text)
  end

  # Generates the audio news for today
  def generate_todays_audio!
    if news_audio.present?
      news_audio.update_column(:filename, generate_audio)
    else
      create_news_audio(filename: generate_audio)
    end
  end
end


