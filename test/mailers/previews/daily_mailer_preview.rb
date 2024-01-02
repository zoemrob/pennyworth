# Preview all emails at http://localhost:3000/rails/mailers/daily_mailer
class DailyMailerPreview < ActionMailer::Preview
  def daily_email(summary)
    DailyMailer.with(user: User.first, summary: summary).daily
  end
end
