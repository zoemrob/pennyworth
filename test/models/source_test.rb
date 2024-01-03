# == Schema Information
#
# Table name: sources
#
#  id          :integer          not null, primary key
#  site_url    :string
#  article_url :string
#  title       :string
#  body        :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
require "test_helper"

class SourceTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
