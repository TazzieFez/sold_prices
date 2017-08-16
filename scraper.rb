require 'mechanize'
require 'scraperwiki'

agent = Mechanize.new
urlbase = 'https://www.domain.com.au/sold-listings/?suburb=pascoe-vale-south-vic-3044,coburg-vic-3058,brunswick-west-vic-3055&ptype=duplex,house,semi-detached,terrace,town-house,villa&price=0-1500000'

  page = agent.get(urlbase)
  
  page.search('.listing-result__standard-premium').each do |li|
    street_add = li.at('.listing-result__address-line-1 span:nth-child(1)').inner_text
    suburb = li.at('.listing-result__address-line-2 span:nth-child(1)').inner_text
    dateall = li.at('.listing-result__hero > span').inner_text
    sold_type = ''
    date = ''
    if dateall.include?('Sold at auction')
      sold_type = "Auction"
      date =dateall[16..27]
    else
      sold_type = "Private"
      date =dateall[23..34]
    end
      house = {
        address: street_add + " " + suburb,
        price: li.at('.listing-result__price span:nth-child(1)').inner_text,
        date: date,
        beds: li.at('.listing-result__left div span:nth-child(1) span span:nth-child(1)').inner_text,
        baths: li.at('.listing-result__left div span:nth-child(3) span span:nth-child(1)').inner_text,
        parking: li.at('.listing-result__left div span:nth-child(5) span span:nth-child(1)').inner_text,
        suburb: suburb,
        sold_type: sold_type
      }

     p house
     ScraperWiki.save_sqlite([:address], house)
  end
  
  i = 2
  
  while i <= 50 do
    
    url = urlbase + "&page=" + i.to_s
    page = agent.get(url)
    
    page.search('.listing-result__standard-pp').each do |li|
    street_add = li.at('.listing-result__address-line-1 span:nth-child(1)').inner_text
    suburb = li.at('.listing-result__address-line-2 span:nth-child(1)').inner_text
    dateall = li.at('.listing-result__left > span').inner_text
    sold_type = ''
    date = ''
    if dateall.include?('Sold at auction')
      sold_type = "Auction"
      date =dateall[16..27]
    else
      sold_type = "Private"
      date =dateall[23..34]
    end
      house = {
        address: street_add + " " + suburb,
        price: li.at('.listing-result__price span:nth-child(1)').inner_text,
        date: date,
        beds: li.at('.listing-result__left div span:nth-child(1) span span:nth-child(1)').inner_text,
        baths: li.at('.listing-result__left div span:nth-child(3) span span:nth-child(1)').inner_text,
        parking: li.at('.listing-result__left div span:nth-child(5) span span:nth-child(1)').inner_text,
        suburb: suburb,
        sold_type: sold_type
      }

     p house
     ScraperWiki.save_sqlite([:address], house)
  end
  i += 1
end
