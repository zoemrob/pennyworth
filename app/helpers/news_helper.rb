module NewsHelper
  def news_link(news)
    return nil if news.news_audio.blank?

    parts = news.news_audio.file_date.split('_')
    name = DateTime.parse(parts.first).strftime('%A, %B %e, %Y')

    slug = news.date
    if parts.count > 1
      name << " #{parts.last.to_i.ordinalize} Edition"
      slug << "_#{parts.last}"
    end

    link_to name, news_path(slug)
  end
end
