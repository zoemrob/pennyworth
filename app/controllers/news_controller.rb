class NewsController < ApplicationController
  PAGE_LIMIT = 25

  def index
    chunk = params[:p].presence || 1
    @news = News.all.limit(PAGE_LIMIT).offset((chunk - 1) * PAGE_LIMIT)
  end

  def show
    dt = params[:date].to_datetime
    @news = News.where(created_at: dt..dt.end_of_day).last
  end
end
