class DCMichelinGuide::Scraper
  #get page
  #scrape page to create list of restaurants
  #make Restaurant instances for each restaurant on the list

  def get_page
    Nokogiri::HTML(open("https://guide.michelin.com/us/washington-dc/bib-gourmand/restaurants"))
  end

  def scrape_restaurants_list
    self.get_page.css('div.resto-inner-title').chomp
  end

  def make_restaurants
    scrape_restaurants_list.each do |resto|
      DCMichelinGuide::Restaurant.new(resto)
    end
  end


end
