# == Schema Information
#
# Table name: subscriptions
#
#  id                :integer          not null, primary key
#  user_id           :integer          not null
#  active            :boolean
#  date_unsubscribed :datetime
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
class Subscription < ApplicationRecord
  belongs_to :user, dependent: :destroy

  scope :active, -> { where(active: true) }
end
