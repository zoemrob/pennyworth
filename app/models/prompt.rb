# == Schema Information
#
# Table name: prompts
#
#  id         :integer          not null, primary key
#  template   :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Prompt < ApplicationRecord
  has_one :news

  # Generates new prompt for the day
  def self.generate
    create(template: Template.new.build)
  end
end
