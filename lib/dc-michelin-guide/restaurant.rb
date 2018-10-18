class DCMichelinGuide::Restaurant

  attr_accessor :name, :url, :cuisine, :location, :distinction, :classification, :price, :services, :mpov, :resto_page#Michelin Point of View

  @@all = []

  def self.distinctions
    puts <<-DOC
      1. One Star
      2. Two Stars
      3. Three Stars
      4. Bib Gourmand
    DOC
  end

  def self.new_from_list(resto)
    temp_name = resto.text.strip!.chop!.strip! #rm leading whitespace -> rm trailing "m" from <span> -> rm trailing whitespace
    self.new(temp_name, resto['href'])
    # binding.pry
  end

  def initialize(name, url)
    @name = name
    @url = "https://guide.michelin.com#{url}"
    @@all << self
  end

  def self.all
    @@all
  end

  def resto_page #gives page of each restaurant
    @resto_page = Nokogiri::HTML(open(self.url))
  end

  def cuisine
    @cuisine = resto_page.css('div.content-header-desc__cuisine').text.strip
  end

  def location
    @location = resto_page.css('div.content-header-desc__area').text.strip
  end

  def distinction
    if resto_page.css('div.v-content-sub-title')[0].text == "Distinction"
      @distinction = resto_page.css('div.restaurant-criteria__desc')[0].text.strip
    end
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
    @mpov= resto_page.css('div.v-content__restaurant-desc .restaurant-desc').text.strip
  end

end
