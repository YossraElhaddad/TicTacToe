module Game
  @@game_board = Array.new(3, "") { Array.new(3, "") }

  SYMBOLS = ["X", "O"]

  def self.SYMBOLS
    SYMBOLS
  end

  def self.game_board
    @@game_board
  end

  def self.no_empty_cells?
    @@game_board.reduce(true) { |result, row| result &= row.none? { |cell| cell == "" } }
  end

  def self.game_over?(symbol)
    self.crossed_row?(symbol) || self.crossed_column?(symbol) || self.crossed_diagonal?(symbol)
  end

  def self.new_game
    @@game_board.map! { |row| row.map! { |cell| cell = "" } }
  end

  def self.display_board
    @@game_board.each do |row|
      row.each { |cell| print " #{cell} |" }
      puts "\n--- --- --- \n"
    end
  end

  private

  def self.crossed_row?(symbol)
    @@game_board.reduce(false) { |result, row| result |= row.all? { |cell| cell == symbol } }
  end

  private

  def self.crossed_column?(symbol)
    @@game_board.transpose.reduce(false) { |result, row| result |= row.all? { |cell| cell == symbol } }
  end

  private

  def self.crossed_diagonal?(symbol)
    left_diagonal =
      @@game_board.each_with_index.reduce(Array.new) do |result, (row, rindex)|
        result << row.select.with_index { |col, cindex|  rindex == cindex }.pop
      end

    right_diagonal =
      @@game_board.each_with_index.reduce(Array.new) do |result, (row, rindex)|
        result << row.select.with_index { |col, cindex|  rindex + cindex == @@game_board.length - 1 }.pop
      end

    left_diagonal.all? { |element| element == symbol } || right_diagonal.all? { |cell| cell == symbol }
  end
end
