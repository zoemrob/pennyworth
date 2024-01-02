class DailyMailer < ApplicationMailer
  def welcome_email
    @name = params[:name]

    mail(to: 'zoe.robertson.m@gmail.com', subject: 'Testing new rails app')
  end

  def daily
    @user = params[:user]
    @summary = params[:summary].html_safe

    mail(to: @user.email, subject: "Master #{@user.first_name}, Here's Your Daily News.")
  end
end
