# == Schema Information
#
# Table name: sources
#
#  id          :integer          not null, primary key
#  site_url    :string
#  article_url :string
#  title       :string
#  body        :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Source < ApplicationRecord
  scope :today, -> { where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day) }

  # Builds Sources from scrapers and saves them
  # @return [ActiveRecord::Relation]
  def self.create_from_scraper
    AllScraper.new.build.map(&:save!)

    today
  end
end
