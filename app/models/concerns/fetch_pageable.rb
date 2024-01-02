module FetchPageable
  def fetch_page(url)
    HTTParty.get(
      url,
      headers: {
        'Accept':	'text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,*/*;q=0.8',
        'User-Agent':	'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:109.0) Gecko/20100101 Firefox/109.0',
        'Accept-Language': 'en-US,en;q=0.5',
        'Referrer': 'https://www.google.com'
      }
    )
  end
end
