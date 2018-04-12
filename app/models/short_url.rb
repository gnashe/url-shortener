class ShortUrl < ApplicationRecord
  validates :short_url,  presence: true
  validates :original_url, presence: true,
                           uniqueness: { case_sensitive: false },
                           url: true
end
