# Scrapes theguardian.com for top topical news
class TheGuardianScraper
  include FetchPageable
  include Scrapeable

  BASE_URL = 'https://www.theguardian.com'.freeze
  US_URL = BASE_URL + '/us-news'.freeze
  WORLD_URL = BASE_URL + '/world'.freeze

  # Scrapes theguardian.com/us-news for headline article
  # @return [Source] new, unsaved Source
  def scrape_us
    @scrape_url = US_URL
    Source.new(**scrape)
  end

  # Scrapes theguardian.com/world-news for headline article
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
      body: article_document.css('div#maincontent p').map(&:text).join('\n')
    }
  end

  # Parses article page url from main page
  # @return [String] article_url
  def parse_page_url = BASE_URL + document.css('a[data-link-name*="news | group-0 | card-@1"]').first.attr('href')
end
