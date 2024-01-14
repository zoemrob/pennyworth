module Scrapeable
  extend ActiveSupport::Concern

  included do
    attr_reader :document, :top_url, :article_document
  end

  def scrape
    unless @scrape_url.blank?
      @page = fetch_page(@scrape_url)
      if @page.ok?
        @page = @page.body
      end
      @document = Nokogiri.HTML4(fetch_page(@scrape_url))
      @top_url = parse_page_url
    end

    @article_document = Nokogiri.HTML4(fetch_page(top_url))
    parse_article
  end
end
