class AllScraper
  SOURCES = [
    CnnScraper,
    ApNewsScraper,
    TheHillScraper
  ].freeze

  attr_reader :raw_data

  def initialize(topic: :us)
    @message = "scrape_#{topic.to_s}".to_sym
  end

  def build
    SOURCES.map do |source|
      scraper = source.new
      data = {}
      data = scraper.send @message if scraper.respond_to? @message

      data
    end
  end
end
