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

  def create
    @short_url = ShortUrl.new(short_url_params)
    if @short_url.save
      redirect_to @short_url
      # handle successful save
    else
      # handle fault
      render html: "uh oh! something went wrong"
    end
  end

  def redirect
    @short_url = ShortUrl.find_by_short_url(params[:short_url])
    redirect_to @short_url.original_url
  end

  private

    def short_url_params
      params.require(:short_url).permit(:original_url)
    end

end
