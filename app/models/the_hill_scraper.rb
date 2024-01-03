# Scraoes thehill.com for top news
class TheHillScraper
  include FetchPageable
  include Scrapeable

  BASE_URL = 'https://www.thehill.com'.freeze

  # Scrapes thehill.com for headline article
  # @return [Source] new, unsaved Source
  def scrape_us
    @scrape_url = BASE_URL
    Source.new(**scrape)
  end

  # Parses top article to fetch relevant body text, title, and urls
  # @return [Hash]
  def parse_article
    {
      site_url: @scrape_url,
      article_url: top_url,
      title: article_document.css('h1').text.strip,
      body: article_document.css('article div.article__text p').map do |n|
        text = n.text
        return '' if text == 'CLICK HERE TO GET THE DAILY WIRE APP'
        return '' if text.include? 'RELATED:'

        text
      end.join('\n')
    }
  end

  # Parses article page url from main page
  # @return [String] article_url
  def parse_page_url = document.css('body div.col-feature a').first.attr('href')
end
