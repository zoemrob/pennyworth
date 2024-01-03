class DeleteFromS3Job < ApplicationJob
  def perform(file:, bucket: ENV['AUDIO_S3_BUCKET'])
    S3Client.new.delete_file(file, bucket)
  end
end
