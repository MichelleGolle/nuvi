require 'nokogiri'
require 'pry'
require 'open-uri'

class Parser
  def parse(url)
    Nokogiri::HTML(open(url).read).css('td a')[1..-1].map { |a| url + a[:href] }
  end
end
