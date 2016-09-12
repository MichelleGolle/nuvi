require './lib/downloader.rb'

class Nuvi
  def initialize(url)
    Downloader.new.download(url)
  end
end

Nuvi.new("http://feed.omgili.com/5Rh5AMTrc4Pv/mainstream/posts/")
