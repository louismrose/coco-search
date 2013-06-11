class SearchesController < ApplicationController
  respond_to :html, :json

  def index
    @searches = Search.all
    respond_with @searches
  end

  def show
    @search = Search.find(params[:id])
    respond_with @search
  end

  def new
    @search = Search.new
    respond_with @search
  end

  def create
    @search = Search.new(search_params)
    Resque.enqueue(SearchRunner, @search.id) if @search.save
    respond_with @search
  end

private
  def search_params
    params.require(:search).permit(:grammar, :evaluation_url)
  end
end
