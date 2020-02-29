require './lib/board'

RSpec.describe Board do
  # first board for testing
  b = Board.new
  b.board[1][0] = 'X'
  b.board[2][0] = 'X'
  b.board[3][0] = 'X'

  b.board[5][0] = 'O'
  b.board[5][1] = 'O'
  b.board[5][2] = 'O'

  b.board[0][0] = 'O'
  b.board[0][1] = 'X'
  b.board[0][2] = 'O'
  b.board[0][3] = 'X'
  b.board[0][4] = 'O'
  b.board[0][5] = 'X'
  b.board[0][6] = 'O'

  b.board[1][1] = 'O'
  b.board[2][1] = 'X'
  b.board[2][2] = 'O'
  b.board[3][1] = 'O'
  b.board[3][2] = 'X'

  # second board for testing
  b2 = Board.new

  b2.board[1][0] = 'X'
  b2.board[2][0] = 'X'
  b2.board[3][0] = 'X'
  b2.board[4][0] = 'X'


  b2.board[5][0] = 'O'
  b2.board[5][1] = 'O'
  b2.board[5][2] = 'O'
  b2.board[5][3] = 'O'

  b2.board[0][0] = 'O'
  b2.board[0][1] = 'X'
  b2.board[0][2] = 'O'
  b2.board[0][3] = 'X'
  b2.board[0][4] = 'O'
  b2.board[0][5] = 'X'
  b2.board[0][6] = 'O'

  b2.board[1][1] = 'O'
  b2.board[2][1] = 'X'
  b2.board[2][2] = 'O'
  b2.board[3][1] = 'O'
  b2.board[3][2] = 'X'
  b2.board[3][3] = 'O'

  full_board = Board.new
  full_board.fill

  describe '#full?' do
    it 'returns true when board is full' do
      expect(full_board.full?).to eql(true)
    end
    it 'returns false when the board is not full' do
      expect(b.full?).to eql(false)
    end
  end
  describe '#valid_column?' do
    it 'returns true if columns has space and is in range' do
      expect(b.valid_column?(1)).to eql(true)
    end

    it 'returns false when columns is full'do
      expect(b.valid_column?(0)).to eql(false)
    end

    it 'returns false when columns is out of range' do
      expect(b.valid_column?(8)).to eql(false)
    end
  end

  describe '#column_in_range?' do
    it 'returns true when columns is 0-7 than 0' do
      expect(b.column_in_range?(0) && b.column_in_range?(6)).to eql(true)
    end

    it 'returns false when columns is less than 0' do
      expect(b.column_in_range?(-1)).to eql(false)
    end

    it 'returns false when columns is greater than 6' do
      expect(b.column_in_range?(7)).to eql(false)
    end
  end
  describe '#column_has_space?' do
    it 'returns true if columns size is less than 7' do
      expect(b.column_has_space?(1)).to eql(true)
    end

    it 'returns true when its more or equal to than 7' do
      expect(b.column_has_space?(0)).to eql(false)
    end
  end
  describe '#winning_coord?' do
    it 'returns true if piece connects 4 of the same pieces in any direction' do
      expect(b2.winning_coord?([5, 3])).to eql(true)
    end

    it 'handles multiple win coords' do
      expect(b2.winning_coord?([1, 1])).to eql(true)
    end

    it 'returns false under all other circumstances' do
      expect(b2.winning_coord?([0, 1])).to eql(false)
    end
  end
  describe '#winning_in_column?' do
    it 'returns true when coord results 4 in a row' do
      expect(b2.winning_in_column?([5, 3])).to eql(true)
    end

    it 'returns false under all other circumstances' do
      expect(b2.winning_in_column?([2, 3])).to eql(false)
    end
  end

  describe '#winning_in_row?' do
    it 'returns true when coord results in connecting 4 of the same pieces in the row' do
      expect(b2.winning_in_row?([4, 0])).to eql(true)
    end

    it 'returns false under all other circumstances' do
      expect(b2.winning_in_row?([0, 6])).to eql(false )
    end
  end

  describe '#winning_in_diagonal?' do
    it 'returns true when coord makes 4 in a row in its diagonals' do
      expect(b2.winning_in_diagonals?([0, 0])).to eql(true)
    end

    it 'returns false under all other circumstances' do
      expect(b2.winning_in_diagonals?([5, 4])).to eql(false)
    end
    end

  describe '#permutations' do
    it 'returns all 4 piece combinations in array' do
      expect(b2.permutations([1, 2, 3, 4, 5])).to eql([[1, 2, 3, 4], [2, 3, 4, 5]])
    end
  end

  describe '#colunm' do
    it 'returns an array with the pieces in the specified column from the bottom' do
      expect(b.column([5, 0])).to eql(%w[O O O])
    end
  end

  describe '#row' do
    it 'returns an array with the pieces in the specific row but stops when it sees a blank space' do
      expect(b.row([0, 0])).to eql(%w[O X X X])
    end
  end

  describe '#diagonal1' do
    it 'returns diagonals of a specified point on the board' do
      expect(b.diagonal1([1, 1])).to eql(%w[O O O])
    end

    it 'handles side edge points' do
      expect(b.diagonal1([0, 2])).to eql(%w[O])
    end

    it 'handles bottom edge points' do
      expect(b.diagonal1([2, 0])).to eql(%w[X O])
    end

    it 'handles corner points' do
      expect(b.diagonal1([0, 0])).to eql(%w[O O O])
    end
  end

  describe '#diagonal2' do
    it 'returns diagonals of a specified point on the board' do
      expect(b.diagonal2([1, 1])).to eql(%w[O O X])
    end

    it 'handles side edge points' do
      expect(b.diagonal2([0, 2])).to eql(%w[O O X])
    end

    it 'handles bottom edge points' do
      expect(b.diagonal2([2, 0])).to eql(%w[O O X])
    end
  end
  
  describe '#beginnings' do
    it 'finds the edge of the board from the bottom and top left' do
      expect(b.beginnings([1, 1])).to eql([[0, 0], [0, 2]])
    end

    it 'handles bottom edge' do
      expect(b.beginnings([2, 0])).to eql([[2, 0], [0, 2]])
    end

    it 'handles side edge' do
      expect(b.beginnings([0, 2])).to eql([[0, 2], [0, 2]])
    end
    it 'handles corners' do
      expect(b.beginnings([0, 0])).to eql([[0, 0], [0, 0]])
    end
  end

  describe '#remove_blanks' do
    it 'returns all pieces connected to the piece at specified index' do
      expect(b.remove_blanks([' ', 'O', 'O', 'O', ' '], 2)).to eql(%w[O O O])
    end

    it 'handles no blanks on left side' do
      expect(b.remove_blanks(['O', ' '], 0)).to eql(%w[O])
    end

    it 'handles no blanks on right side' do
      expect(b.remove_blanks([' ', 'O'], 1)).to eql(%w[O])
    end
  end

end