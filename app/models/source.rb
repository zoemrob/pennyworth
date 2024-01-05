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
#  prompt_id   :integer
#  summary     :text
#
class Source < ApplicationRecord
  belongs_to :prompt, optional: true

  include OpenAiGeneratable

  scope :today, -> { where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day) }
  scope :most_recent, ->(number) { order(created_at: :desc).limit(number) }

  after_create :summarize, if: :needs_summary?

  # Builds Sources from scrapers and saves them
  # @return [ActiveRecord::Relation]
  def self.create_from_scraper
    AllScraper.new.build.map(&:save!)

    most_recent(AllScraper::SOURCES.count)
  end

  def clean_body
    send(:body=, body.split('\n').map(&:strip).reject(&:empty?).join(' '))
  end

  def needs_summary? = OpenAI.rough_token_count(body) > 1000

  def summarize
    prompt = Prompt.create_for_source(self)
    update_column(:summary, generate_text(prompt))
  end

  def to_article
    Article.new(self)
  end
end
