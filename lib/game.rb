class Game
  require_relative '../lib/board'
  require_relative '../lib/player'
  def initialize
    @board = Board.new
    @player = Player.new(@board)
    @current_piece = 'X'
  end
  
  def play
    loop do
      coord = @player.add_piece(@current_piece)
      switch_piece
      @board.render
      break if @board.winning_coord?(coord) || @board.full?
    end
  end
  
  def switch_piece
    @current_piece = if @current_piece == 'X'
                       'O'
                     else
                       'X'
                     end
  end
end