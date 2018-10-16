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
        puts "Lists One Star Restaurants"
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

  def goodbye
    puts "See you next time! Bon Appetit!"
  end
end
