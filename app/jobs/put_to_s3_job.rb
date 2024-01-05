class PutToS3Job < ApplicationJob
  def perform(tmp_path:, bucket: ENV['AUDIO_S3_BUCKET'])
    S3Client.put_file(tmp_path, bucket)
    File.delete(Rails.root.join(tmp_path))
  end
end
