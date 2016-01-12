class Board
  attr_reader :grid

  def initialize(pop = true)
    @grid = Array.new(8) {Array.new(8) {NilPiece.new}}
    populate if pop
  end

  def move(start_pos, end_pos)
    raise "There is no piece to move" if self[start_pos].nil?
    move!(start_pos, end_pos) if valid_move(start_pos, end_pos)
    raise "You cannot move there with that piece" unless valid_move?(start_pos, end_pos)
  end

  def move!(start_pos, end_pos)
    self[end_pos] = self[start_pos]
    self[end_pos].pos = end_pos
    self[start_pos] = NilPiece.new
  end

  def valid_move?(start_pos, end_pos)
    duped_board = self.dup
    current_piece = duped_board[start_pos]
    move!(start_pos, end_pos)
    duped_board.flatten.each do |square|
      if current_piece.oppenent?(square.pos)
        square.moves
        square.put_in_check?
      end
    end
  end

  def dup
    duped_board = Board.new(false)
    (0..7).each do |row|
      (0..7).each do |col|
        duped_board[[row,col]] = self[[row,col]].dup(duped_board)
      end
    end
    duped_board
  end

  def populate

    @grid[1].each_with_index do |square, col|
      self[[1,col]] = Pawn.new([1, col], :black, self)
    end
    @grid[6].each_with_index do |square, col|
      self[[6,col]] = Pawn.new([6, col], :white, self)
    end

    self[[0,0]] = Rook.new([0,0], :black, self)
    self[[0,7]] = Rook.new([0,7], :black, self)
    self[[7,0]] = Rook.new([7,0], :white, self)
    self[[7,7]] = Rook.new([7,7], :white, self)

    self[[0,1]] = Knight.new([0,1], :black, self)
    self[[0,6]] = Knight.new([0,6], :black, self)
    self[[7,1]] = Knight.new([0,1], :white, self)
    self[[7,6]] = Knight.new([7,6], :white, self)

    self[[0,2]] = Bishop.new([0,2], :black, self)
    self[[0,5]] = Bishop.new([0,5], :black, self)
    self[[7,2]] = Bishop.new([0,2], :white, self)
    self[[7,5]] = Bishop.new([7,5], :white, self)

    self[[0,3]] = Queen.new([0,3], :black, self)
    self[[7,3]] = Queen.new([7,3], :white, self)

    self[[0,4]] = King.new([0,4], :black, self)
    self[[7,4]] = King.new([7,4], :white, self)

  end

  def in_bounds?(pos)
    row, col = pos
    row.between?(0, 7) && col.between?(0, 7)
  end

  def [](pos)
    row, col = pos
    grid[row][col]
  end

  def []=(pos, value)
    row, col = pos
    grid[row][col] = value
  end

  def win?       #game_over
    false
  end
end
