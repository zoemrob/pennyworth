class SourcesController < ApplicationController
  def index
    @sources = Source.order(id: :desc).paginate(page: params[:page])
  end

  def show
    @source = Source.find params[:id]
  end
end
