require 'nokogiri'
require 'digest'
require 'redis'

class XMLProcessor
  def process(file)
    xml_doc = Nokogiri::XML(File.open(file))
    content = xml_doc.content
    # create a unique hash from the string of contents to store in redis and
    # compare with other files to prevent dupes
    content_hash = Digest::SHA256.digest(content)
    redis = Redis.new
    # redis.sadd will add the content_hash and return true only if it does not
    # already exist in CONTENT_HASHES
    if redis.sadd('CONTENT_HASHES', content_hash)
      redis.rpush('NEWS_XML', content)
    end
  end
end
