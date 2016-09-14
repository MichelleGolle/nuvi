require './lib/parser.rb'
require './lib/downloader.rb'
require './lib/unzipper.rb'
require './lib/xml_processor.rb'

class Nuvi
  def initialize(url)
    #parse html from the url into list of zips
    url_list = Parser.new.parse(url)
    #download each zip url, unzip it, get xml files, parse xml files, upload to redis
    url_list.each do |zip_url|
      download_parse_and_upload_to_redis(zip_url)
    end
  end
  def download_parse_and_upload_to_redis(zip_url)
    zip_directory = File.join(Dir.pwd, '.tmp', 'zips')
    xml_directory = File.join(Dir.pwd, '.tmp', 'xmls')
    # Create the target directory if it does not exist
    FileUtils.mkdir_p(zip_directory) unless Dir.exist?(zip_directory)
    #save zip file
    downloaded_zip_file = Downloader.new.download(zip_directory, zip_url)
    #unzip file
    xml_folder = Unzipper.new.unzip(xml_directory, downloaded_zip_file)
    #get xml files list
    xml_files = Dir[File.join(xml_folder, '*.xml')]
    # xml processor will check for duplicates and push to redis
    xml_files.each { |file| XMLProcessor.new.process(file) }
  end
end

Nuvi.new("http://feed.omgili.com/5Rh5AMTrc4Pv/mainstream/posts/")
