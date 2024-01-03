# AllScraper iterates through all the web scrapers stored in SOURCES and
# invokes the corresponding scrape_ message
class AllScraper
  SOURCES = [
    CnnScraper,
    ApNewsScraper,
    TheHillScraper
  ].freeze

  attr_reader :raw_data

  # Builds and AllScraper instance
  # @param topic [Symbol]: either :us or :world, the topic to scrape for
  # @return [AllScraper]
  def initialize(topic: :us)
    @message = "scrape_#{topic.to_s}".to_sym
  end

  # Iterates through AllScraper.SOURCES and sends relevant scrape message
  # @return [Array<Source>] an array of new, unsaved Sources
  def build
    SOURCES.map do |source|
      scraper = source.new
      data = {}
      data = scraper.send @message if scraper.respond_to? @message

      data
    end
  end
end
