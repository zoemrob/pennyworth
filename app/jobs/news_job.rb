class NewsJob < ApplicationJob
  attr_reader :users, :news

  # Generates newsletter and sends to subscribes
  def perform(model: Prompt::GPT_3_5, force_new: false, users: [])
    @users = users

    Source.create_from_scraper if force_new

    @news = News.create(prompt: Prompt.create_for_news(model: model))

    users.nil? ? mail_to_users : news.mail
  end

  def mail_to_users
    users.each { |user| news.mail_to(user) }
  end
end
