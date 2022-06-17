require "./game.rb"

class Player
  include Game

  attr_reader :symbol
  attr_reader :name
  attr_accessor :turn

  def initialize(name, symbols = Game.SYMBOLS)
    @name = name
    @turn = false
    @symbol = symbols.sample

    symbols.delete(@symbol)
  end

  def play
    loop do
      puts "Play at position (separated by ','): "

      position = gets.chomp.split(",")
      position.map! { |index| index.to_i }

      row = position[0]
      col = position[1]

      if Game.game_board.dig(row, col) == ""
        Game.game_board[row][col] = symbol
        Game.display_board
        break

      elsif Game.game_board.dig(row, col) == nil
        puts "Invalid index. Try again."

      else
        puts "You cannot overwrite in a nonempty position. Try again."
      end
    end
  end
end

player1 = Player.new("ONE")
player2 = Player.new("TWO")

players = []

players << player1 << player2

current_player = players.sample
current_player.turn = true

loop do
  if current_player.turn == true

    puts "Player #{current_player.name} is playing"

    current_player.play

    if Game.no_empty_cells? || Game.game_over?(current_player.symbol)

      if Game.game_over?(current_player.symbol)
        puts "Player #{current_player.name} has won!"

      elsif Game.no_empty_cells?
        puts "It is a draw!"

      end

      puts "Play again? (y/n)"
      answer = gets.chomp
      answer == 'y' ? Game.new_game : break

    end

    player1.turn, player2.turn = player2.turn, player1.turn

    current_player = (current_player == player1) ? player2 : player1

  end
end
