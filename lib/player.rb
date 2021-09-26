# frozen_string_literal: true

class Player
  attr_reader :name, :piece

  def initialize(name, piece)
    @name = name
    @piece = piece
  end

  # prompts and verifies player input in column choice
  # returns a verified input
  # @param choices [Array]
  def choose_column(choices)
    loop do
      instruction_message(choices)
      choice = get_input
      return choice if choices.include?(choice)

      error_message(choices)
    end
  end

  def instruction_message(choices)
    puts "Available Columns #{choices}"
  end

  def error_message(choices)
    puts "Invalid Column, choose in #{choices}"
  end

  # simple input get input method
  # did this to allow for testing
  def get_input
    gets.chomp.to_i
  end
end
