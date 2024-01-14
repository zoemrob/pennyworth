# Scrapes foxnews.com for top topical news
class FoxNewsScraper
  include FetchPageable
  include Scrapeable

  BASE_URL = 'https://www.foxnews.com'.freeze
  US_URL = BASE_URL + '/us'.freeze
  WORLD_URL = BASE_URL + '/world'.freeze

  # Scrapes foxnews.com/us-news for headline article
  # @return [Source] new, unsaved Source
  def scrape_us
    @scrape_url = US_URL
    Source.new(**scrape)
  end

  # Scrapes foxnews.com/world-news for headline article
  # @return [Source] new, unsaved Source
  def scrape_world
    @scrape_url = WORLD_URL
    Source.new(**scrape)
  end

  # Parses top article to fetch relevant body text, title, and urls
  # @return [Hash]
  def parse_article
    {
      site_url: @scrape_url,
      article_url: @top_url,
      title: article_document.css('h1').text.strip,
      body: article_document.css('div.article-body p').map(&:text).join('\n')
    }
  end

  # Parses article page url from main page
  # @return [String] article_url
  def parse_page_url = BASE_URL + document.css('main a').first.attr('href')
end
