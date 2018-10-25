class DCMichelinGuide::CLI #Our CLI Controller

  def call
    puts "***************************************"
    puts "Michelin Restaurants in Washington, DC:"
    puts "***************************************"
    list_distinctions
    menu
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
      if input == "1"
        puts "Restaurants with One Star:"
        render_list(input)
      elsif input == "2"
        puts "Restaurants with Two Stars:"
        render_list(input)
      elsif input == "3"
        puts "Restaurants with Three Stars:"
        render_list(input)
      elsif input == "4"
        puts "Bib Gourmand Restaurants:"
        render_list(input)
      elsif input == "exit"
        goodbye
        exit
      else
        puts "That is not a valid selection. Please try again."
      end
    end
  end

  def show_list(distinction)
    restaurants = DCMichelinGuide::Restaurant.find_by_distinction(distinction)
    restaurants.each.with_index do |resto, index|
      puts "#{index+1}. #{resto.name}"
    end
  end

  def render_list(input)
    DCMichelinGuide::Scraper.new.make_restaurants(input) if DCMichelinGuide::Restaurant.find_by_distinction(input) == []
    show_list(input)
    resto_choice
    list_distinctions
  end

  def show_restaurant(input)
    resto = DCMichelinGuide::Restaurant.all[input-1]
    DCMichelinGuide::Scraper.scrape_resto_page(resto) if resto.price == nil
    puts "**********************************"
    puts resto.name
    puts "**********************************"
    puts resto.distinction
    puts "Type of Cuisine: #{resto.cuisine}"
    puts resto.price
    puts resto.classification
    puts "----------------------------------"
    puts resto.location
    puts resto.hours
    puts "----------------------------------"
    puts "Services:"
    resto.services.each do |service|
      puts "• #{service.text.strip}"
    end
    puts "----------------------------------"
    puts "*Michelin Guide's Point Of View*"
    puts ""
    puts resto.mpov.gsub(/(.{1,#{75}})(\s+|\Z)/, "\\1\n")
    puts "----------------------------------"
    render_list(resto.distinction_number)
    resto_choice
  end

  def resto_choice
    puts "Choose a restaurant for more information or type list to see other distinctions or exit:"
    input_resto = gets.strip.downcase
    if input_resto == "exit"
      exit
    elsif input_resto == "list"
      list_distinctions
      menu
    else
      input_integer = input_resto.to_i
      if input_integer > DCMichelinGuide::Restaurant.all.length || input_integer <= 0
        puts "That is not a valid selection"
        resto_choice
      else
        show_restaurant(input_integer)
      end
    end
  end

  def goodbye
    puts "See you next time! Bon Appétit"
  end
end
