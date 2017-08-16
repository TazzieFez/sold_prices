# This is a template for a Ruby scraper on morph.io (https://morph.io)
# including some code snippets below that you should find helpful

# require 'scraperwiki'
# require 'mechanize'
#
# agent = Mechanize.new
#
# # Read in a page
# page = agent.get("http://foo.com")
#
# # Find somehing on the page using css selectors
# p page.at('div.content')
#
# # Write out to the sqlite database using scraperwiki library
# ScraperWiki.save_sqlite(["name"], {"name" => "susan", "occupation" => "software developer"})
#
# # An arbitrary query against the database
# ScraperWiki.select("* from data where 'name'='peter'")

# You don't have to do things with the Mechanize or ScraperWiki libraries.
# You can use whatever gems you want: https://morph.io/documentation/ruby
# All that matters is that your final data is written to an SQLite database
# called "data.sqlite" in the current working directory which has at least a table
# called "data".

require 'mechanize'
require 'scraperwiki'

agent = Mechanize.new
url = 'https://morph.io/documentation/examples/australian_members_of_parliament'

["1", "2", "3"].each do |page_number|
  page = agent.get(url + "?page=" + page_number)

  page.at('.search-filter-results').search('li').each do |li|
    member = {
      title: li.at('.title').inner_text.strip,
      electorate: li.search('dd')[0].inner_text,
      party: li.search('dd')[1].inner_text,
      url: li.at('.title a').attr('href')
    }

    p member
    ScraperWiki.save_sqlite([:title], member)
  end
end
