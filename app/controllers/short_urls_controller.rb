class ShortUrlsController < ApplicationController
  def home
    @short_url = ShortUrl.new
  end

  def index
    @short_urls = ShortUrl.all
  end

  def show
    @short_url = ShortUrl.find(params[:id])
  end

  def redirect
    @short_url = ShortUrl.find_by_short_url(params[:short_url])
    redirect_to @short_url.original_url
  end
end
