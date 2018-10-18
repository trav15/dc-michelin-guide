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
  end

  def menu
    input = nil
    while input != "exit"
      puts "Choose your distinction or type exit:"
      input = gets.strip.downcase
      case input
      when "1"
        DCMichelinGuide::Scraper.new.make_restaurants(input.to_i)
        puts "Restaurants with One Star"
        show_list
        resto_choice
        list_distinctions
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
    end
  end

  def show_restaurant(input)
    resto = DCMichelinGuide::Restaurant.all[input-1]
    puts "****************************"
    puts resto.name
    puts "****************************"
    puts resto.distinction
    puts "Type of Cuisine: #{resto.cuisine}"
    puts "----------------------------"
    puts resto.location
    puts resto.hours
    puts "----------------------------"
    puts "Services:"
    resto.services.each do |service|
      puts "• #{service.text.strip}"
    end
    puts "----------------------------"
  end

  def resto_choice
    puts "Choose a restaurant for more information or type exit:"
    input_resto = gets.strip.to_i
    show_restaurant(input_resto)
  end

  def goodbye
    puts "See you next time! Bon Appetit!"
  end
end
