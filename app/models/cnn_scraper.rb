# Scrapes cnn.com for top topical news
class CnnScraper
  include FetchPageable
  include Scrapeable

  BASE_URL = 'https://www.cnn.com'.freeze
  US_URL = BASE_URL + '/us'.freeze
  WORLD_URL = BASE_URL + '/world'.freeze

  # Scrapes cnn.com/us for headline article
  # @return [Source] new, unsaved Source
  def scrape_us
    @scrape_url = US_URL
    Source.new(**scrape)
  end

  # Scrapes cnn.com/world for headline article
  # @return [Source] new, unsaved Source
  def scrape_world
    @scrape_url = WORLD_URL
    Source.new(**scrape)
  end

  # Parses top article to fetch relevant body text, title, and urls
  # @return [Hash]
  def parse_article
    data = {
      site_url: @scrape_url,
      article_url: @top_url,
      title: article_document.css('h1').text.strip,
    }

    if top_url.include?('live-news')
      data[:body] = article_document.css('aside li').map do |element|
        element.children.map { |c| c.text }.join(' ')
      end.join('\n')
    else
      data[:body] = article_document.css('p.paragraph').map { |element| element.text }.join('\\n')
    end

    data
  end

  # Parses article page url from main page
  # @return [String] article_url
  def parse_page_url = BASE_URL + document.css('.container a').first.attr('href')
end
