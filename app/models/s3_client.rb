# Small wrapper for S3 client
class S3Client
  def self.method_missing(m, *args, &block)
    new.send(m, *args, &block)
  end

  # @return [S3Client]
  def initialize
    @client = Aws::S3::Client.new
  end

  # Puts an file to supplied bucket
  def put_file(path, bucket)
    @client.put_object({
                         body: File.binread(Rails.root.join(path)),
                         bucket: bucket,
                         key: path.split('/').last
                       })
  end


  # Deletes a file from supplied bucket
  def delete_file(file, bucket)
    @client.delete_object({
                            key: file,
                            bucket: bucket
                          })
  end

  def file_exists?(file, bucket)
    @client.head_object({
                            key: file,
                            bucket: bucket
                          })
    true
  rescue Aws::S3::Errors::NotFound
    false
  end
end
