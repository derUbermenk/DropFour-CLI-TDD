# require frozen_string_literal: true

# Contains dropped pieces by a player object
class Board
  def initialize
    @cells = Array.new(6) { Array.new(7, nil) }

    # this contains the position of the last drop
    @last_drop = { piece: nil, row: nil, col: nil }
  end

  def drop_piece(piece, column, row = 5)
    curr_cell = @cells[row][column]
    if curr_cell.nil?
      @cells[row][column] = piece
      @last_drop = { piece: piece, row: row, col: column }
    else
      upper_row = row - 1
      drop_piece(piece, column, upper_row)
    end
  end

  # returns last piece added if winner
  # @return [String] unicode for last piece added
  # winning condition:
  #   * piece has formed a either a 4 piece horizontal, vertical
  #     ... or diagonal line
  # https://en.wikipedia.org/wiki/Connect_Four 
  def winner
    match = horizontal_match || vertical_match || diagonal_match
    match ? @last_drop[:piece] : nil
  end

  def horizontal_match
    get_row_elements(@last_drop[:row]).join.match?(create_pattern(@last_drop[:piece]))
  end

  def vertical_match
    get_row_elements(@last_drop[:col]).join
  end

  def diagonal_match
    diagonal1, diagonal2 = get_diagonal_elements(@last_drop[:row], @last_drop[col])
  end

  # checks if board is full
  def full?
    @cells.map { |row| !row.all?(&:nil?) }.all?(true)
  end

  def display; end

  private

  # creates a 4 char string out of piece
  # @param [piece]
  # @return [String]
  def create_pattern(piece)
    Array.new(4,piece).join
  end

  # returns all elements of cells in given row
  def get_row_elements(row); end

  # returns all elements of cells in given column
  def get_column_elements(column); end

  # returns all elements of cells in given diagonal
  def get_diagonal_elements(diagonal); end
end
