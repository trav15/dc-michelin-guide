class DCMichelinGuide::CLI #Our CLI Controller

  def call
    puts "Michelin Restaurants in Washington, DC:"
    list_distinctions
    menu
    goodbye
  end

  def list_distinctions
    puts "Here are the distinctions"
    puts <<-DOC
      1. One Star
      2. Two Stars
      3. Three Stars
      4. Bib Gourmand
    DOC
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
      when "exit"
        exit
      end
    end
  end

  def goodbye
    puts "See you next time! Bon Appetit!"
  end
end
