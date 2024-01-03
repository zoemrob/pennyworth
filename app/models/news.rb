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

  # from OpenAiGeneratable
  after_create :generate_todays_news!, if: :body_blank?

  # Helper method for after_create hook
  # @return [Boolean]
  def body_blank? = body.blank?
end
