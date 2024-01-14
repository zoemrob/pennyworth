# Scrapes generic linked site from an ambiguous source
class GenericLinkedScraper
  include FetchPageable
  include Scrapeable

  # @param url [String] url to the article to scrape
  def initialize(url)
    @top_url = url
  end

  # Attempts to scrape meaninful text from an ambiguous source
  # @return [Hash]
  def parse_article
    title = article_document.css('h1').text.strip
    {
      site_url: host_url,
      article_url: @top_url,
      title: title,
      body: article_document.css('p').map(&:text).join('\n').strip.presence || title
    }
  end

  private

  # Parses host url from thje supplied url
  # @return [String] host_url
  def host_url
    uri = URI.parse(@top_url)
    uri.scheme + '://' + uri.host
  end
end
