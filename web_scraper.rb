require 'httparty'
require 'nokogiri'
require 'pry'
require 'json'
require 'csv'

 doc = HTTParty.get('https://www.yogajournal.com/poses/types') #create a variable called “doc” and set it equal to an HTTParty GET request of the URL we are going to scrape.
#above is how we request the page we're going to scrape
parse_page = Nokogiri::HTML(doc) # transform http response into a nokogiri object.
yoga_page = [] # empty array where we will store all the details.

#parse_page.css('h2.m-card--header-text') #  can now see the strings I want to pull, where we parse the data
#parse_page.css('h2.m-card--header-text').first.text # this  makes them accessible as individuals
# this is where we parse the data

parse_page.css('.m-card--header').collect do |pose_type|
  pose_type.css('h2').text
    post_name = pose_type.text
yoga_page.push(post_name)
end

#Pry.start(binding) # to be able to look into the code and check works as expected

CSV.open('yoga_info.csv', 'w' ) do |csv| # push my array into a csv file
csv << [yoga_page]
 end



