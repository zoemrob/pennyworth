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
require "test_helper"

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
