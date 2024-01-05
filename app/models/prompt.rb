# == Schema Information
#
# Table name: prompts
#
#  id         :integer          not null, primary key
#  template   :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  model      :string
#
class Prompt < ApplicationRecord
  has_one :news
  has_many :sources

  GPT_4 = 'gpt-4'.freeze
  GPT_3_5 = 'gpt-3.5-turbo-16k'.freeze

  enum model: {
    gpt4: GPT_4,
    gpt3_5: GPT_3_5
  }

  # Generates new prompt for the day
  def self.create_for_news(model: GPT_4)
    t = Template.new(model: model).build
    create(template: t.body, model: model, sources: t.sources)
  end

  def self.create_for_source(source, model: GPT_3_5)
    t = Source::Template.new(source, model).build
    create(template: t.body, model: model, sources: [source])
  end

  def model_name = Prompt.models[model]
end
