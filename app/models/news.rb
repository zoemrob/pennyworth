class News < ApplicationRecord
  belongs_to :user
  belongs_to :summary

  include OpenAiGeneratable

  def mail
    DailyMailer.with(user: user, summary: body).daily
  end

  after_create :generate_todays_news, if: :body_blank?

  def generate_todays_news
    update_column(:body, generate_content)

    self
  end

  def body_blank? = body.blank?
end
