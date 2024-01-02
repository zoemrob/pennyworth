class Summary < ApplicationRecord
  has_one :news

  def self.generate
    create(template: Template.new.build)
  end
end
