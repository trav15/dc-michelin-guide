class DCMichelinGuide::CLI #Our CLI Controller

  def call
    puts "Michelin Restaurants in Washington, DC:"
    list_distinctions
    menu
    goodbye
  end

  def list_distinctions
    puts "Here are the distinctions:"
    @restaurant = DCMichelinGuide::Restaurant.distinctions
    DCMichelinGuide::Scraper.new.make_restaurants
  end

  def menu
    input = nil
    while input != "exit"
      puts "Choose your distinction or type exit:"
      input = gets.strip.downcase
      case input
      when "1"
        puts "Lists One Star Restaurants"
        show_list
        # binding.pry
      when "2"
        puts "Lists Two Stars Restaurants"
      when "3"
        puts "Lists Three Stars Restaurants"
      when "4"
        puts "Lists Bib Gourmand Restaurants"
      when "exit"
        exit
      end
    end
  end

  def show_list
    DCMichelinGuide::Restaurant.all.each.with_index do |resto, index|
      puts "#{index+1}. #{resto.name}"
      puts resto.website
      # puts "Services:"
      # resto.services.each do |service|
      #   puts "• #{service.text.strip}"
      # end
    end
  end

  def goodbye
    puts "See you next time! Bon Appetit!"
  end
end
