class DCMichelinGuide::Restaurant

  attr_accessor :name, :url, :cuisine, :location, :distinction, :distinction_number, :classification, :price, :services, :mpov, :hours, :website, :resto_page
  @@all = []

  def self.distinctions
    puts <<-DOC
      1. One Star
      2. Two Stars
      3. Three Stars
      4. Bib Gourmand
    DOC
  end

  def initialize(name, url, distinction_choice, distinction_number)
    @name = name
    @url = "https://guide.michelin.com#{url}"
    @distinction = distinction_choice
    @distinction_number = distinction_number
    @@all << self
  end

  def self.all
    @@all
  end

  def self.find_by_distinction(distinction)
    @@all.select{|resto| resto.distinction_number == distinction}
  end
end
