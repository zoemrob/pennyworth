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
  belongs_to :news, dependent: :destroy

  # Helper method to get just file name
  # @todo not needed anymore, but would need to write a migration first to update filenames
  #       also need to adjust filename to be not null
  # @return [String]
  def file = filename&.split('/')&.last

  # Gets CloudFront distribution link
  def url = "https://#{ENV['AUDIO_CLOUDFRONT_DISTRO']}/#{file}"

  def file_date = file[5..].split('.').first

  # Removes file from S3 and deletes record
  def destroy
    DeleteFromS3Job.perform_later(file: file)
    delete
  end
end
