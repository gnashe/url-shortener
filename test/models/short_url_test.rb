require 'test_helper'

class ShortUrlTest < ActiveSupport::TestCase
  def setup
    @shorturl = ShortUrl.new(short_path: "xCeFvG", original_url: "https://www.ruby-lang.org/en/documentation/quickstart/")
  end

  test "original url should be valid" do
    assert @shorturl.valid?
  end

  test "originalurl validation should accept urls" do
    valid_urls = %w[https://www.nytimes.com/2012/08/09/us/more-casinos-and-internet-gambling-threaten-shakopee-tribe.html?_r=1&hp
                    https://google.com http://google.com]
    valid_urls.each do |valid_url|
      @shorturl.original_url = valid_url 
      assert @shorturl.valid?, "#{valid_url.inspect} should be valid"
    end
  end

  test "original url validation should reject invalid urls" do
    invalid_urls = %w[https://#######/ https://a.a.a.a.a http://aewqrlkmaivmlkwmekrj.xzc/]
    invalid_urls.each do |invalid_url|
      @shorturl.original_url = invalid_url
      assert_not @shorturl.valid?, "#{invalid_url.inspect} should be invalid"
    end
  end

  test "urls should be unique" do
    duplicate_shorturl = @shorturl.dup
    @shorturl.save
    assert_not duplicate_shorturl.valid?
  end
end
