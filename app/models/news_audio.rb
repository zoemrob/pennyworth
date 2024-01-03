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
class NewsAudio < ApplicationRecord
  belongs_to :news

  # Helper method to get just file name
  # @return [String]
  def file = filename.split('/').last

  # Gets CloudFront distribution link
  def url = "https://#{ENV['AUDIO_CLOUDFRONT_DISTRO']}/#{file}"

  # Removes file from S3 and deletes record
  def destroy
    DeleteFromS3Job.perform_later(file: file)
    delete
  end
end
