class DCMichelinGuide::Restaurant

  attr_accessor :name, :url, :distinction, :cuisine, :location, :price, :services, :mpov #Michelin Point of View

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

end
