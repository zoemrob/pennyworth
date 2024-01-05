module News::Mailable
  def mail
    Subscription.active.includes(:user).each do |sub|
      DailyMailer.with(user: sub.user, summary: body).daily.deliver_later
    end
  end

  def mail_to(user)
    if user.subscription&.active?
      DailyMailer.with(user: user, summary: body).daily.deliver_later
    end
  end
end
