require 'nokogiri'
require 'open-uri'
require 'pry'

class Parser
  def parse(url)
    Nokogiri::HTML(open(url).read).css('td a')[1..-1].map { |a| url + a[:href] }
  end
end
