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

  enum honorific: %i[sir miss madame master]
end
