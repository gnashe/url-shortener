class ShortUrlsController < ApplicationController
  def home
    render html: "Hello, world!"
  end

  def shortened
    render html: "Hello, #{params[:short_url]}"
  end

  def show_all
    render html: "Hello, show all!"
  end

  def redirect
    @short_url = ShortUrl.find_by_short_url(params[:short_url])
    redirect_to @short_url.original_url
  end
end
