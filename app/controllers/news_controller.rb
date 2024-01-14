class NewsController < ApplicationController
  PAGE_LIMIT = 25

  def index
    @news = News.all.includes(:news_audio).paginate(page: params[:page])
  end

  def show
    dt, index = parse_date_param
    @news = News.where(created_at: dt..dt.end_of_day).includes(:news_audio)[index]
  end

  def parse_date_param
    ps = params[:date].split('_')
    return [ps.first.to_datetime, 0] if ps.count == 1

    [ps.first.to_datetime, ps.last.to_i - 1]
  end
end
