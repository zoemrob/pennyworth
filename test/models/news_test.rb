# == Schema Information
#
# Table name: news
#
#  id         :integer          not null, primary key
#  body       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  prompt_id  :integer
#
require "test_helper"

class NewsTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
