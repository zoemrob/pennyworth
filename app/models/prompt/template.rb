# OpenAI GPT-4 template
class Prompt::Template
  attr_reader :sources

  # @return [Prompt::Template]
  def initialize
    @sources = Source.today.most_recent(AllScraper::SOURCES.count).presence || Source.create_from_scraper
  end

  # Iterates through Sources, and renders them in the prompt template
  # @return [String] HTML formatted prompt
  def build
    mapped = @sources.map do |source|
      source.body = source.body.split('\n').map(&:strip).reject(&:empty?).join(' ')
      source
    end

    ApplicationController.render 'templates/news_prompt', locals: { data: mapped.to_json }, layout: false
  end
end
