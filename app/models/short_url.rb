class ShortUrl < ApplicationRecord
  validates :short_url,  presence: true
  validates :original_url, presence: true,
                           uniqueness: { case_sensitive: false },
                           url: true

  before_validation :clean_url, :create_short_url

  REGEX_PROTOCOL = /https?:\/\//ix
  PERMISSIBLE_VALS = [*'a'..'z', *'A'..'Z', *'0'..'9'].join

  # ensure the url starts with it protocol and is normalized
  def clean_url
    url = self.original_url
    url = url.strip
    if url !~ REGEX_PROTOCOL
      url = "http://#{url}"
    end
    self.original_url = URI.parse(url).normalize.to_s
  end

  def create_short_url
    path = (0...6).map { PERMISSIBLE_VALS[rand(PERMISSIBLE_VALS.size)] }.join
    self.short_url = path
  end

end
