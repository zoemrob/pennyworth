class TheHillScraper
  include FetchPageable
  include Scrapeable

  BASE_URL = 'https://www.thehill.com'.freeze

  def scrape_us
    @scrape_url = BASE_URL
    Source.new(**scrape)
  end

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

  def parse_page_url = document.css('body div.col-feature a').first.attr('href')
end
