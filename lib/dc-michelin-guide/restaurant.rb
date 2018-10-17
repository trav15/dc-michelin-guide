class DCMichelinGuide::Restaurant

  attr_accessor :name, :distinction, :cuisine, :location, :price, :services, :mpov #Michelin Point of View

  @@all = []

  def self.distinctions
    puts <<-DOC
      1. One Star
      2. Two Stars
      3. Three Stars
      4. Bib Gourmand
    DOC
  end
  # 
  # def initialize(name, cuisine, location, price)
  #   @name = name
  #   @cuisine = cuisine
  #   @location = location
  #   @price = price
  # end

end
