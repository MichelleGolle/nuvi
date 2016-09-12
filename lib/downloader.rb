require 'open-uri'
require 'nokogiri'

class Downloader
  def download(url)
    doc = Nokogiri::HTML(open(url))
    puts doc
  end
end
