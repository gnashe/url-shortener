class ShortUrlsController < ApplicationController
  DUPLICATE_ERR_MSG = "has already been taken"
  INVALID_URI_ERR_MSG = "not a valid uri"

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
    else
      # handle duplicated original_urls
      @short_url.errors.messages[:original_url].each { |err_msg|
        if (err_msg == DUPLICATE_ERR_MSG)
          redirect_to ShortUrl.find_by_original_url(@short_url[:original_url])
        elsif (err_msg == INVALID_URI_ERR_MSG )
          render 'home'
        else
          render html: "Uh oh, something went wrong..."
        end
      }
    end
  end

  def redirect
    @short_url = ShortUrl.find_by_short_path(params[:short_path])
    redirect_to @short_url.original_url
  end

  private

    def short_url_params
      params.require(:short_url).permit(:original_url)
    end

end
