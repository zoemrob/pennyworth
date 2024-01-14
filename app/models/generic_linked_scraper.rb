# Scrapes generic linked site for top topical news
class GenericLinkedScraper
  include FetchPageable
  include Scrapeable

  def initialize(url)
    @top_url = url
  end

  # Parses top article to fetch relevant body text, title, and urls
  # @return [Hash]
  def parse_article
    {
      site_url: host_url,
      article_url: @top_url,
      title: article_document.css('h1').text.strip,
      body: article_document.css('p').map(&:text).join('\n')
    }
  end

  private

  def host_url
    uri = URI.parse(@top_url)
    uri.scheme + '://' + uri.host
  end
end
