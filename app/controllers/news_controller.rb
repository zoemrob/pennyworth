class NewsController < ApplicationController
  def show
    dt = params[:date].to_datetime
    @news = News.where(created_at: dt..dt.end_of_day).pluck(:body).last
  end
end
