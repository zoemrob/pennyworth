module News::Mailable
  def mail
    Subscription.active.includes(:user).each do |sub|
      DailyMailer.with(user: sub.user, summary: body).daily.deliver_later
    end
  end
end
