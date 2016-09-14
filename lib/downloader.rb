class Downloader
  attr_accessor :directory

  def download(directory, url)
    uri = URI.parse(url)
    destination = File.join(directory, File.basename(uri.path))

    if !File.exist?(destination)
      http = Net::HTTP.new(uri.host, uri.port)
      http.request(Net::HTTP::Get.new(uri)) do |response|
        save(response, destination)
      end
    end
    destination
  end

private

  def save(response, destination)
    #read content of zipfile and write to file to be saved in tmp/zips folder
    open(destination, 'w') do |file|
      response.read_body do |str|
        file.write(str)
      end
    end
  end
end
