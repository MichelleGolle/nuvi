require 'zip'
require 'pry'

class Unzipper
  def unzip(base_directory, zip_file)
    destination = File.join(base_directory, File.basename(zip_file, '.zip'))
    #prevent duplicate creation
    FileUtils.rm_rf(destination)
    FileUtils.mkdir_p(destination)
    #unzip
    Zip::File.open(zip_file) do |contents|
      contents.each do |file|
        file.extract(File.join(destination, file.name))
      end
    end
    destination
  end
end
