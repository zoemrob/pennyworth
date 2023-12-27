class DailyMailer < ApplicationMailer
  def welcome_email
    @name = params[:name]

    mail(to: 'zoe.robertson.m@gmail.com', subject: 'Testing new rails app')
  end
end
