# frozen_string_literal: true

# Message prompts and errors
module Messages
  def prompt
    "\n> "
  end

  def prompt_board_size
    print "Enter the grid size for your game (between 3 to 10):#{prompt}"
  end

  def error_board_size
    system('clear')
    print "Invalid board size! Enter the grid size for your game (between 3 to 10):#{prompt}"
  end

  def prompt_total_player
    system('clear')
    print "Enter how many players in the game (2 to 8 players):#{prompt}"
  end

  def error_total_player
    system('clear')
    print "Invalid number of players! Enter how many players in the game (2 to 8 players):#{prompt}"
  end

  def prompt_cpu_player(player_num)
    system('clear')
    print "Player ##{player_num}, are you a (h)uman or (c)omputer?#{prompt}"
  end

  def prompt_create_name(player_num)
    system('clear')
    print "Player ##{player_num}, enter your name:#{prompt}"
  end

  def error_create_name(player_num, name)
    system('clear')
    print "Player ##{player_num}, #{name} is taken. Enter your name:#{prompt}"
  end

  def prompt_create_symbol(name)
    system('clear')
    print "#{name}, enter a single symbol as your token (no numbers):#{prompt}"
  end

  def error_create_symbol(name, symbol)
    system('clear')
    puts "#{name}, '#{symbol}' is not available or taken"
    print "Enter a single symbol as your token (no numbers):#{prompt}"
  end

  def prompt_get_position(player)
    print "#{player.name}, enter a number to place '#{player.symbol}' in an available spot:#{prompt}"
  end

  def error_get_position(player)
    print "Sorry #{player.name} (#{player.symbol}), invalid spot. Try again:#{prompt}"
  end

  def cpu_prompt_creation(player_num, cpu)
    system('clear')
    puts "Computer ##{player_num} has chosen name and symbol: #{cpu.name} #{cpu.symbol}"
    sleep(2.5)
  end

  def cpu_position(cpu, position_num)
    puts "#{cpu.name} (#{cpu.symbol}) chose position '#{position_num}'"
    sleep(1.5)
  end

  def message_winner
    puts "\e[1mGAME OVER!\e[22m #{current_player.name} is the winner!\n\n"
  end

  def message_tie
    puts "\e[1mDRAW GAME!\e[22m\n\n"
  end
end