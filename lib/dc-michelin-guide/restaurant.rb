class DCMichelinGuide::Restaurant

  attr_accessor :name, :url, :distinction, :cuisine, :location, :price, :services, :mpov, :resto_page#Michelin Point of View

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

end
