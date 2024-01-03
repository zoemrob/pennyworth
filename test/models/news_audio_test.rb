# == Schema Information
#
# Table name: news_audios
#
#  id         :integer          not null, primary key
#  news_id    :integer          not null
#  filename   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require "test_helper"

class NewsAudioTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
