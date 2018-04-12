require 'test_helper'

class ShortUrlTest < ActiveSupport::TestCase
  def setup
    @shorturl = ShortUrl.new(short_url: "http://localhost:3000/xCeFvG", original_url: "https://www.ruby-lang.org/en/documentation/quickstart/")
  end

  test "original url should be valid" do
    assert @shorturl.valid?
  end

  test "original url should be present" do
    @shorturl.original_url = "     "
    assert_not @shorturl.valid?
  end

  test "short url should be present" do
    @shorturl.short_url = "     "
    assert_not @shorturl.valid?
  end

  test "originalurl validation should accept urls" do
    valid_urls = %w[http://mywebsite.com https://www.url-with-querystring.com/?url=has-querystring
                         https://google.com http://google.com]
    valid_urls.each do |valid_url|
      @shorturl.original_url = valid_url 
      assert @shorturl.valid?, "#{valid_url.inspect} should be valid"
    end
  end

  test "original url validation should reject invalid urls" do
    invalid_urls = %w[ht@tp:00 i!@#$%^&*(.com httpz://googlez.org]
    invalid_urls.each do |invalid_url|
      @shorturl.original_url = invalid_url
      assert_not @shorturl.valid?, "#{invalid_url.inspect} should be invalid"
    end
  end

  test "urls should be unique" do
    duplicate_shorturl = @shorturl.dup
    duplicate_shorturl.original_url = @shorturl.original_url.upcase
    @shorturl.save
    assert_not duplicate_shorturl.valid?
  end
end
