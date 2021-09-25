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
    piece_pattern = create_pattern(@last_drop[:piece])
    diagonal1 = get_diagonal_elements(@last_drop[:row], @last_drop[:col], 1)
    diagonal2 = get_diagonal_elements(@last_drop[:row], @last_drop[:col], -1)

    [diagonal1, diagonal2].inject(false) do |has_match, diagonal|
      has_match || diagonal.join.match?(piece_pattern)
    end
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
  def get_row_elements(row) 
    @cells[row]
  end

  # returns all elements of cells in given column
  def get_column_elements(column)
    @cells.each_with_object([]) do |row, queried_column|
      queried_column << row[column]
    end
  end

  # returns the elements in the diagonal passing through 
  # cell index by row column combo
  # @param row [Integer]
  # @param column [Integer]
  # @param slope can either be 1 -- pointing to origin or
  # ... -1 pointing away from origin [0][0]
  # @return [Array] an array of elements contained by queried diagonal
  def get_diagonal_elements(row, column, slope)
    get_points(column, row, slope).each_with_object([]) do |point, elements|
      elements << @cells[point[1]][point[0]]
    end
  end

  # given points x and y, find all points in a line
  # with a given slope within some x and y bounds
  # @param x_point [Integer]
  # @param y_point [Integer]
  # @param slope [Integer]
  # @param x_bound [Integer]
  # @param y_bound [Integer]
  # @return [Array] an Array containing all [x,y] value pairs
  def get_points(x_point, y_point, slope, x_bound = 6, y_bound = 5)
    y_int = y_intercept(x_point, y_point, slope)
    x_values = [*0..6]
    possible_y = [*0..5]

    x_values.each_with_object([]) do |x, points|
      y = (slope*x) + y_int
      points << [x, y] if possible_y.include?(y)
    end
  end

  # derives the y intercept of a line containing
  # x, y given that it has given slope
  # @param x [Integer]
  # @param y [Integer]
  # @param slope [Integer]
  # @return [Integer] the y intercept
  def y_intercept(x_point, y_point, slope)
    y_point - (slope * x_point)
  end
end
