require 'open-uri'

class UrlValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if value.blank?
    begin
      resp = open(value).status.include? "200"
    rescue URI::InvalidURIError
      resp = false
    rescue SocketError
      resp = false
    end
    unless resp == true
      record.errors[attribute] << "not a valid uri"
    end
  end
end

class ShortUrl < ApplicationRecord
  validates :short_path,  presence: true, uniqueness: true
  validates :original_url, presence: true,
                           uniqueness: { case_sensitive: false },
                           url: true

  before_validation :clean_url, :create_short_path

  REGEX_PROTOCOL = /https?:\/\//ix
  PERMISSIBLE_VALS = [*'a'..'z', *'A'..'Z', *'0'..'9'].join

  # ensure the url starts with it protocol and is normalized
  def clean_url
    url = self.original_url
    url = url.gsub(' ', '')
    url = url.strip
    if url !~ REGEX_PROTOCOL
      url = "http://#{url}"
    end
    self.original_url = URI.parse(url).normalize.to_s
  end

  def create_short_path
    path = (0...6).map { PERMISSIBLE_VALS[rand(PERMISSIBLE_VALS.size)] }.join
    self.short_path = path
  end

end
