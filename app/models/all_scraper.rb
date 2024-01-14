# AllScraper iterates through all the web scrapers stored in SOURCES and
# invokes the corresponding scrape_ message
class AllScraper
  # AllScraper finds all models ending in 'Scraper', except these
  EXCLUDED = [
    AllScraper,
    GenericLinkedScraper
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
    sources.shuffle.map do |source|
      scraper = source.new
      data = {}
      data = scraper.send @message if scraper.respond_to? @message

      data
    end
  end

  private

  # Digs through the models directory to find all classes ending with 'Scraper', returning a list of Classes
  # @return [Array<Class>]
  def sources
    models = Dir.glob('app/models/*.rb').map do |file|
      file[/app\/models\/(.*)\.rb/, 1].camelize.constantize
    end

    models.select {|c| c.to_s.include?('Scraper')}
          .reject {|c| EXCLUDED.include? c  }
          .map {|c| c.to_s.constantize }
  end
end
