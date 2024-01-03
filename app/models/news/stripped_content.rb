class News::StrippedContent
  include ActionView::Helpers::SanitizeHelper

  def initialize(news_content)
    @news_content = news_content
  end

  def to_s
    strip_links(
      Nokogiri.HTML4(
        DailyMailerPreview.new.daily_email(@news_content).body.to_s
      ).css('div.container').to_s
    )
  end
end
