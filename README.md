Sold Prices Scraper
===================

This scraper takes sold property data from the [Domain](https://www.domain.com.au) real estate website and puts it into a simple sql table that can be filtered and sorted to make better sense of property values and likely sale prices.  

This is a ruby based scraper that uses [Mechanize](https://github.com/sparklemotion/mechanize) and runs  on [Morph](https://morph.io).

##Use this for your self

To use the scraper, make a new scaper on [Morph](https://morph.io) and copy the scraper.rb file to your [GitHub](github.com) repo. 

You can then update the 'urlbase' variable to take account of where you can looking for property (change suburbs) and any other filters you want to apply (such as max price or minimum bedrooms). 

Once you have your variables sorted out you can go back to [Morph](https://morph.io) and run the scraper, export to csv (or another format) and starting analysing what you have found. 
