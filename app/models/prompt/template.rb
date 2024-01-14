# OpenAI GPT-4 template
class Prompt::Template
  attr_reader :sources, :model, :body

  # @param model [String], one of Prompt::GPT_4 or Prompt::GPT_3_5
  # @param source_count [Integer]
  # @return [Prompt::Template]
  def initialize(model:, source_count: 3)
    @model = model
    @sources = Source.today.most_recent(source_count).presence || Source.create_from_scraper(count: source_count)
  end

  # Iterates through Sources, and renders them in the prompt template
  # @return [Prompt::Template]
  def build
    @sources.each(&:clean_body)
    mapped = @sources.map { |s| s.to_article.to_h }

    @body = ApplicationController.render "templates/news_prompt_#{friendly_model_name}", locals: { data: mapped.to_json }, layout: false
    self
  end

  private

  def friendly_model_name = model.gsub('.', '_')
end
