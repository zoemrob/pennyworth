# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  email      :string
#  first_name :string
#  last_name  :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  honorific  :string
#
class User < ApplicationRecord
  has_one :subscription

  enum honorific: { sir: 0, miss: 1, madame: 2, master: 3 }

  after_create :subscribe

  def subscribe
    create_subscription(active: true)
  end
end
