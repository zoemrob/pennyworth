module News::OpenAiGeneratable
  def generate_content
    OpenAiClient.new.get_text(summary.template)
  end
end


