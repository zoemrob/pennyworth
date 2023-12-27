class News < ApplicationRecord
  belongs_to :user
  belongs_to :summary

  include OpenAiGeneratable

  def mail
    update_column(:body, generate_content) unless body.present?
    DailyMailer.with(user: user, summary: body).daily
  end
end
