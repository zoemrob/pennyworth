class Source < ApplicationRecord
  scope :today, -> { where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day) }

  def self.create_from_scraper
    AllScraper.new.build.map(&:save!)
  end
end
