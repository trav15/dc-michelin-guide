class DCMichelinGuide::Scraper
  #get page
  #scrape page to create list of restaurants
  #make Restaurant instances for each restaurant on the list

  def get_page
    @doc = []
    url_fragments = ["1-star-michelin", "2-stars-michelin", "3-stars-michelin", "bib-gourmand"]
    url_fragments.each do |url_fragment|
      @doc = Nokogiri::HTML(open("https://guide.michelin.com/us/washington-dc/#{url_fragment}/restaurants"))
    end
    @doc
  end

  def scrape_restaurants_list
    self.get_page.css('div.resto-inner-title a') #gives link and restaurant name (but name needs to be stripped)
  end

  def make_restaurants
    scrape_restaurants_list.each do |resto|
      DCMichelinGuide::Restaurant.new_from_list(resto)
    end
  end

  def self.scrape_resto_page #gives page of each restaurant
    puts "************Scraping restaurant**********"
    @resto_page = Nokogiri::HTML(open(self.url))
  end

end
