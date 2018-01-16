require 'mechanize'
require 'scraperwiki'

agent = Mechanize.new
#urlbase = 'https://www.domain.com.au/sold-listings/?suburb=brunswick-west-vic-3055,coburg-vic-3058,coburg-north-vic-3058,coburg-east-vic-3056,pascoe-vale-south-vic-3044&ptype=duplex,house,semi-detached,terrace,town-house,villa&price=0-1100000&sort=solddate-desc'
urlbase = 'https://www.domain.com.au/sold-listings/maydena-tas-7140/?ssubs=1'

  p "page 1"
  page = agent.get(urlbase)
  houseno = 1
  
  page.search('.listing-result__standard-standard , .listing-result__standard-premium, .listing-result__standard-pp').each do |li|
    street_add = li.at('.listing-result__address-line-1 span:nth-child(1)').inner_text
    suburb = li.at('.listing-result__address-line-2 span:nth-child(1)').inner_text
    dateall = li.at('.listing-result__hero > span , .listing-result__left > span').inner_text
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
        lat: li.at('a div meta:nth-child(1)').attributes['content'].value,
        long: li.at('a div meta:nth-child(2)').attributes['content'].value,
        sold_type: sold_type,
        link: li.at('div.listing-result__left > a').attributes['href'].value
      }

     p house
         ScraperWiki.save_sqlite([:address], house)
     p houseno
     houseno += 1

  end
  
  i = 2
  
  while i <= 25 do
    
    url = urlbase + "&page=" + i.to_s
    p "page " + i.to_s
    page = agent.get(url)
    
    page.search('.listing-result__standard-standard , .listing-result__standard-premium, .listing-result__standard-pp').each do |li|
    street_add = li.at('.listing-result__address-line-1 span:nth-child(1)').inner_text
    p "Address " + street_add
    suburb = li.at('.listing-result__address-line-2 span:nth-child(1)').inner_text
    dateall = li.at('.listing-result__hero > span , .listing-result__left > span').inner_text
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
        lat: li.at('a div meta:nth-child(1)').attributes['content'].value,
        long: li.at('a div meta:nth-child(2)').attributes['content'].value,
        sold_type: sold_type,
        link: li.at('div.listing-result__left > a').attributes['href'].value
      }

     p house
           ScraperWiki.save_sqlite([:address], house)
     p houseno
     houseno += 1
  end
  i += 1
  sleep 1
end


