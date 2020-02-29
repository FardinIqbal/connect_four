class Board
  attr_accessor :board
  @@winning_O = %w[O O O O]
  @@winning_X = %w[X X X X]
  def initialize
    @board = Array.new(6) { Array.new(7, ' ') }
  end

  def render
    # puts the entire 2D board
    separate_row
    7.times do |row|
      print_row(row)
      separate_row
    end
  end

  def separate_row
    # puts ------------- to separate each row of the board
    13.times do
      print '-'
    end
    puts ''
  end

  def print_row(row)
    # puts the specified row oof the 2D board
    6.times do |column|
      # puts each of the columns in the specified row
      print '|'
      print @board[column][6 - row]
    end
    print '|'
    puts ''
  end

  def drop_piece(column, piece)
    # adds a piece to the lowest row available in the column
    @board[column].prepend(piece) if valid_column?(column)
    @board[column].pop
    @board[column]
  end

  def valid_column?(column)
    # returns true if column is in range and has space
    if column_in_range?(column)
      column_has_space?(column)
    else
      false
    end
  end

  def full?
    full = true
    6.times do |column|
      full = false if column_has_space?(column)
    end
    puts 'Draw' if full
    full
  end

  def column_has_space?(column)
    # returns true unless columns is full
    size = 0
    board[column].each do |piece|
      size += 1 if piece != ' '
    end
    size < 7
  end

  def column_in_range?(column)
    # returns true if column is less than or equal to 6
    column <= 5 && column >= 0
  end

  def winning_coord?(coord)
    # returns trow if coord results in connecting 4 of the sme pieces
    if winning_in_column?(coord) || winning_in_row?(coord) || winning_in_diagonals?(coord)
      puts 'Game over'
      true
    else
      false
    end
  end

  def winning_in_column?(coord)
    # returns true if the coord results in 4 of the same pieces in its column
    possibilities = permutations(column(coord))
    winning?(possibilities)
  end

  def winning_in_row?(coord)
    # returns true if the coord results in 4 of the same pieces in its row
    possibilities = permutations(row(coord))
    winning?(possibilities)
  end

  def winning_in_diagonals?(coord)
    # returns true if the coord results in 4 of the same pieces in either of its diagonals
    d1_possibilities = permutations(diagonal1(coord))
    d2_possibilities = permutations(diagonal2(coord))
    winning?(d1_possibilities) || winning?(d2_possibilities)
  end

  def winning?(possibilities)
    possibilities.include?(@@winning_O) || possibilities.include?(@@winning_X)
  end

  def permutations(array, result = [])
    # assumes array.size is >= 4
    array.each_index do |index|
      result << array[index...index + 4] if index <= array.size - 4
    end
    result
  end

  def column(coord)
    # returns all the pieces in the column, index, as an array
    column = board[coord[0]]
    column.delete(' ')
    column
  end

  def row(coord)
    # returns all the pieces in the row, index, as an array
    row = @board.map { |column| column[coord[1]] }

    remove_blanks(row, coord[0])
  end

  def diagonal1(coord)
    diagonals = []
    pos = beginnings(coord)[0]
    until pos[0] == 6 || pos[1] == 6 || @board[pos[0]][pos[1]] == ' '
      diagonals << @board[pos[0]][pos[1]]
      pos[0] = pos[0] + 1
      pos[1] = pos[1] + 1
    end
    diagonals.delete(nil)
    diagonals
  end

  def diagonal2(coord)
    diagonals = []
    pos = beginnings(coord)[1]
    until pos[0] == 6 || pos[1] == 6 || @board[pos[0]][pos[1]] == ' '
      diagonals << @board[pos[0]][pos[1]]

      pos[0] = pos[0] + 1
      pos[1] = pos[1] - 1
    end
    diagonals
  end

  def beginnings(coord)
    b1 = coord
    b2 = coord

    b1 = [b1[0] - 1, b1[1] - 1] while b1[0] > 0 && b1[1] > 0

    b2 = [b2[0] - 1, b2[1] + 1] while b2[0] > 0 && b2[1] < 7

    [b1, b2]
  end

  def remove_blanks(array, index_of_point)
    array if array.include?(' ')

    result = []
    array.each_with_index do |piece, index|
      break if index >= index_of_point && piece == ' '

      result << piece
      result = [] unless index > index_of_point || piece != ' '
    end
    result
  end

  def fill
    6.times do |column|
      7.times do
        drop_piece(column, 'X')
      end
    end
  end
end
