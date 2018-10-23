class DCMichelinGuide::Scraper
  #get page
  #scrape page to create list of restaurants
  #make Restaurant instances for each restaurant on the list

  def get_page(input)
    if input == 1
      url_fragment = "1-star-michelin"
    elsif input == 2
      url_fragment = "2-stars-michelin"
    elsif input == 3
      url_fragment = "3-stars-michelin"
    elsif input == 4
      url_fragment = "bib-gourmand"
    else
    end
    puts "**********Scraping Page*********"
    Nokogiri::HTML(open("https://guide.michelin.com/us/washington-dc/#{url_fragment}/restaurants"))
  end

  def scrape_restaurants_list(input)
    self.get_page(input).css('div.resto-inner-title a') #gives link and restaurant name (but name needs to be stripped)
  end

  def make_restaurants(input)
    scrape_restaurants_list(input).each do |resto|
      DCMichelinGuide::Restaurant.new_from_list(resto)
    end
  end

  def self.scrape_resto_page(restaurant) #gives page of each restaurant
    puts "************Scraping restaurant**********"
    @resto_page ||= Nokogiri::HTML(open(restaurant.url))
    add_attributes(restaurant)
  end

  def self.add_attributes(restaurant)
    restaurant.cuisine = resto_page.css('div.content-header-desc__cuisine').text.strip
    restaurant.location = resto_page.css('div.content-header-desc__area').text.strip
    if resto_page.css('div.v-content-sub-title')[0].text == "Distinction"
      restaurant.distinction = resto_page.css('div.restaurant-criteria__desc')[0].text.strip
    end
    if resto_page.css('div.v-content-sub-title')[1].text == "Classification"
      restaurant.classification = resto_page.css('div.restaurant-criteria__desc')[1].text.strip
    end

    if resto_page.css('div.v-content-sub-title')[2].text == "Price"
      price_symbols = resto_page.css('div.restaurant-criteria__icon')[2].text.strip
      price_level = resto_page.css('div.restaurant-criteria__desc')[2].text.strip
      restaurant.price = "#{price_symbols} • #{price_level}"
    end
    restaurant.mpov = resto_page.css('div.v-content__restaurant-desc .restaurant-desc').text.strip
    restaurant.services = resto_page.css('li .service-desc')
    restaurant.website = resto_page.css('div.location-item__desc a.o-link')[1]['href']
    restaurant.hours = resto_page.css('div.location-item__desc p')[2].text.strip
  end

  def cuisine

  end

  def location
  end

  def distinction

  end

  def classification

  end

  def price

  end

  def mpov

  end

  def services

  end

  def website

  end

  def hours

  end


end
