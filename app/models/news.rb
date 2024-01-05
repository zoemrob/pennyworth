# == Schema Information
#
# Table name: news
#
#  id         :integer          not null, primary key
#  body       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  prompt_id  :integer
#
class News < ApplicationRecord
  belongs_to :prompt
  has_one :news_audio

  include OpenAiGeneratable
  include Mailable

  scope :today, -> { where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day) }

  # from OpenAiGeneratable
  after_create :generate_todays_news!, if: :body_blank?

  # Helper method for after_create hook
  # @return [Boolean]
  def body_blank? = body.blank?

  # Generates the news for today, including audio
  # @return [self]
  def generate_todays_news!
    generate_todays_text!
    generate_todays_audio!

    self
  end

  # Generates the news for today
  def generate_todays_text!
    update_column(:body, generate_text(prompt))
  end

  # Generates the audio news for today
  def generate_todays_audio!
    content = News::StrippedContent.new(body).to_s

    if news_audio.present?
      news_audio.update_column(:filename, generate_audio(content))
    else
      create_news_audio(filename: generate_audio(content))
    end
  end
end
