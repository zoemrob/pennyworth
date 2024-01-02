class ApNewsScraper
  include FetchPageable
  include Scrapeable

  BASE_URL = 'https://www.apnews.com'.freeze
  US_URL = BASE_URL + '/us-news'.freeze
  WORLD_URL = BASE_URL + '/world-news'.freeze

  def scrape_us
    @scrape_url = US_URL
    Source.new(**scrape)
  end

  def scrape_world
    @scrape_url = WORLD_URL
    Source.new(**scrape)
  end

  def parse_article
    {
      site_url: @scrape_url,
      article_url: @top_url,
      title: article_document.css('h1.Page-headline').text.strip,
      body: article_document.css('main p').map { |element| element.text }.join('\n')
    }
  end

  def parse_page_url = document.css('div.PageList-items a').first.attr('href')
end
