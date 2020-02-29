class Player
  require_relative '../lib/board'

  def initialize(board)
    @board = board
  end

  def add_piece(piece)
    column = ask_for_column - 1
    @board.drop_piece(column, piece)
    [column, column.size - 1]
  end

  def ask_for_column
    puts 'Enter which column you would like to place your next piece'
    input = gets.to_i
    input = gets.to_i until input_validation(input)
    input
  end

  def input_validation(column)
    if column >= 1 && column <= 6
      true
    else
      puts 'Invalid input!'
    end
  end
end