class NewsController < ApplicationController
  PAGE_LIMIT = 25

  def index
    chunk = params[:p].presence || 1
    @news = News.all.includes(:news_audio).limit(PAGE_LIMIT).offset((chunk - 1) * PAGE_LIMIT)
  end

  def show
    dt, index = parse_date_param
    @news = News.where(created_at: dt..dt.end_of_day)[index]
  end

  def parse_date_param
    ps = params[:date].split('_')
    return [ps.first.to_datetime, 0] if ps.count == 1

    [ps.first.to_datetime, ps.last.to_i - 1]
  end
end
