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
    else
      url_fragment "bib-gourmand"
    end
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


end
