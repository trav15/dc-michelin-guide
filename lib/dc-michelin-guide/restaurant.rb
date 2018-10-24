class DCMichelinGuide::Restaurant

  attr_accessor :name, :url, :cuisine, :location, :distinction, :classification, :price, :services, :mpov, :hours, :website, :resto_page
  @@all = []

  def self.distinctions
    puts <<-DOC
      1. One Star
      2. Two Stars
      3. Three Stars
      4. Bib Gourmand
    DOC
  end

  def self.new_from_list(resto, input)
    temp_name = resto.text.strip!.chop!.strip! #rm leading whitespace -> rm trailing "m" from <span> -> rm trailing whitespace
    self.new(temp_name, resto['href'], input)
  end

  def initialize(name, url, distinction_choice)
    @name = name
    @url = "https://guide.michelin.com#{url}"
    assign_distinction(distinction_choice)
    @@all << self
    @resto_page = Nokogiri::HTML(open(self.url))
    puts "****SCRAPING RESTAURANT******"
  end

  def self.all
    @@all
  end

  def self.find_by_distinction(distinction)
    @@all.find(distinction)
  end

  def cuisine
    @cuisine = resto_page.css('div.content-header-desc__cuisine').text.strip
  end

  def location
    @location = resto_page.css('div.content-header-desc__area').text.strip
  end

  def assign_distinction(distinction_choice)
    if distinction_choice == "1"
      @distinction = "One Star • High quality cooking, worth a stop"
    elsif distinction_choice == "2"
      @distinction = "Two Stars • Excellent cooking, worth a detour"
    elsif distinction_choice == "3"
      @distinction = "Three Stars • Exceptional cuisine, worth a special journey"
    elsif distinction_choice == "4"
      @distinction = "Bib Gourmand • Inspectors’ favourites for good value"
    end
  end

  def distinction
    @distinction
  end

  def classification
    if resto_page.css('div.v-content-sub-title')[1].text == "Classification"
      @classification = resto_page.css('div.restaurant-criteria__desc')[1].text.strip
    end
  end

  def price
    if resto_page.css('div.v-content-sub-title')[2].text == "Price"
      price_symbols = resto_page.css('div.restaurant-criteria__icon')[2].text.strip
      price_level = resto_page.css('div.restaurant-criteria__desc')[2].text.strip
      @price = "#{price_symbols} • #{price_level}"
    end
  end

  def mpov
    @mpov = resto_page.css('div.v-content__restaurant-desc .restaurant-desc').text.strip
  end

  def services
    @services = resto_page.css('li .service-desc')
  end

  def website
    @website = resto_page.css('div.location-item__desc a.o-link')[1]['href']
  end

  def hours
    @hours = resto_page.css('div.location-item__desc p')[2].text.strip
  end

end
