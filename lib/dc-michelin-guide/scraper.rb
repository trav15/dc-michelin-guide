class DCMichelinGuide::Scraper

  def get_page(input)
    if input == "1"
      url_fragment = "1-star-michelin"
    elsif input == "2"
      url_fragment = "2-stars-michelin"
    elsif input == "3"
      url_fragment = "3-stars-michelin"
    elsif input == "4"
      url_fragment = "bib-gourmand"
    end
    puts "**********Scraping Page*********"
    Nokogiri::HTML(open("https://guide.michelin.com/us/washington-dc/#{url_fragment}/restaurants"))
  end

  def scrape_restaurants_list(input)
    self.get_page(input).css('div.resto-inner-title a') #gives link and restaurant name (but name needs to be stripped)
  end

  def make_restaurants(input)
    scrape_restaurants_list(input).each do |resto|
      temp_name = resto.text.strip!.chop!.strip! #rm leading whitespace -> rm trailing "m" from <span> -> rm trailing whitespace
      if input == "1"
        distinction = "One Star • High quality cooking, worth a stop"
      elsif input == "2"
        distinction = "Two Stars • Excellent cooking, worth a detour"
      elsif input == "3"
        distinction = "Three Stars • Exceptional cuisine, worth a special journey"
      elsif input == "4"
        distinction = "Bib Gourmand • Inspectors’ favourites for good value"
      end
      DCMichelinGuide::Restaurant.new(temp_name, resto['href'], distinction, input)
    end
  end

  def self.scrape_resto_page(resto)
    puts "************Scraping restaurant**********"
    resto_page = Nokogiri::HTML(open(resto.url))
    resto.cuisine = resto_page.css('div.content-header-desc__cuisine').text.strip
    resto.location = resto_page.css('div.content-header-desc__area').text.strip
    if resto_page.css('div.v-content-sub-title')[1].text == "Classification"
      resto.classification = resto_page.css('div.restaurant-criteria__desc')[1].text.strip
    end
    if resto_page.css('div.v-content-sub-title')[2].text == "Price"
      price_symbols = resto_page.css('div.restaurant-criteria__icon')[2].text.strip
      price_level = resto_page.css('div.restaurant-criteria__desc')[2].text.strip
      resto.price = "#{price_symbols} • #{price_level}"
    end
    resto.mpov = resto_page.css('div.v-content__restaurant-desc .restaurant-desc').text.strip
    resto.services = resto_page.css('li .service-desc')
    resto.website = resto_page.css('div.location-item__desc a.o-link')[1]['href']
    resto.hours = resto_page.css('div.location-item__desc p')[2].text.strip
  end
end
