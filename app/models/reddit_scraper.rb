# Scrapes reddit.com for top topical news
class RedditScraper
  include FetchPageable
  include Scrapeable

  BASE_URL = 'https://www.reddit.com'.freeze
  NEWS_URL = BASE_URL + '/r/news'.freeze

  # Scrapes reddit.com/r/news for headline article
  # @return [Source] new, unsaved Source
  def scrape_us
    @scrape_url = NEWS_URL
    Source.new(**scrape)
  end

  # Scrapes reddit.com/r/news for headline article
  # @return [Source] new, unsaved Source
  def scrape_world
    @scrape_url = NEWS_URL
    Source.new(**scrape)
  end

  # Parses top article to fetch relevant body text, title, and urls
  # @return [Hash]
  def parse_article
    GenericLinkedScraper.new(linked_article_url).scrape
  end

  # Parses article page url from main page
  # @return [String] article_url
  def parse_page_url = BASE_URL + document.css('main article a').first.attr('href')

  private

  # Parses the linked article for the reddit post
  # @return [String] linked_article_url
  def linked_article_url = article_document.css('main a[target="_blank"]').first.attr('href')
end
