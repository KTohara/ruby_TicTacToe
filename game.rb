# frozen_string_literal: true

require_relative 'board'
require_relative 'player'
require_relative 'display'

# Tic-Tac-Toe game logic
class Game
  include Display
  attr_reader :board, :players, :current_player, :total_symbols, :total_names

  def initialize
    @board = nil
    @players = []
    @current_player = nil
    @total_names = []
    @total_symbols = []
  end

  def play
    setup_board
    setup_players
    display_lets_play
    play_turns
    game_over
  end

  private

  def setup_board
    system('clear')
    puts "\e[1mLets Play...\e[22m\n\n".center(95)
    display_banner
    sleep(2)
    system('clear')
    @board = Board.new(input_board_size)
    board.create_board
  end

  def setup_players
    (1..total_players).each do |player_num|
      display_create_name_prompt(player_num)
      name = create_name(player_num)
      total_names << name

      display_create_symbol_prompt(name)
      symbol = create_symbol(name)
      total_symbols << symbol

      players << Player.new(name, symbol)
    end
    @current_player = players.first
  end

  def input_board_size
    display_board_size_prompt
    board_size = nil
    begin
      loop do
        input = Integer(gets)
        if !input.between?(3, 10)
          display_board_size_error
        else
          board_size = input
          break
        end
      end
    rescue StandardError
      display_board_size_error
      retry
    end
    board_size
  end

  def total_players
    display_total_player_prompt
    player_num = nil
    begin
      loop do
        input = Integer(gets)
        if input < 2
          display_total_player_error
        else
          player_num = input
          break
        end
      end
    rescue StandardError
      display_total_player_error
      retry
    end
    player_num
  end

  def create_name(player_num)
    input = gets.chomp
    return input unless (total_names + total_symbols).include?(input) && total_names.any?

    display_create_name_error(player_num, input)
    create_name(player_num)
  end

  def create_symbol(name)
    input = gets.chomp
    return input if input.match?(/^[^\d]$/) && !(total_symbols + total_names).include?(input)

    display_create_symbol_error(name, input)
    create_symbol(name)
  end

  def play_turns
    until board.full?(total_symbols)
      display_play_turn_prompt(current_player)
      num = player_turn(current_player)
      board.place_symbol(num, current_player.symbol)
      break if board.win?(current_player.symbol)

      @current_player = switch_current_player
    end
  end

  def player_turn(player)
    input = nil
    while input.nil?
      num = gets.chomp.to_i
      if board.valid_move?(num)
        input = num
        break
      end
      display_player_turn_error(player)
    end
    input
  end

  def switch_current_player
    @current_player = players.rotate!.first
  end

  def game_over
    board.show
    if board.win?(current_player.symbol)
      display_winner
    else
      display_tie
    end
  end
end