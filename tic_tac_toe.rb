# frozen_string_literal: true

require 'pry'

class Grid
  def initialize
    @board_status = [1, 2, 3, 4, 5, 6, 7, 8, 9]
  end

  def update(postition, mark_type)
    @board_status[postition - 1] = mark_type
  end

  def finished?
    if win?
      'WIN'
    elsif full?
      'FULL'
    else
      'NO'
    end
  end

  def to_s
    grid = @board_status
    "\n" \
    " #{grid[0]} | #{grid[1]} | #{grid[2]} \n-----------\n" \
    " #{grid[3]} | #{grid[4]} | #{grid[5]} \n-----------\n" \
    " #{grid[6]} | #{grid[7]} | #{grid[8]} "
  end

  private

  attr_reader :board_status

  def win?
    row_win? || col_win? || diagonal_win?
  end

  def full?
    @board_status.uniq.size == 2
  end

  def row_win?
    row = 0
    win = false
    3.times do
      if (@board_status[0 + row].eql? @board_status[1 + row]) && (@board_status[0 + row].eql? @board_status[3 + row])
        win = true
      end
      row += 3
    end
    win
  end

  def col_win?
    col = 0
    win = false
    3.times do
      if (@board_status[0 + col].eql? @board_status[3 + col]) && (@board_status[0 + col].eql? @board_status[6 + col])
        win = true
      end
      col += 1
    end
    win
  end

  def diagonal_win?
    (@board_status[0].eql? @board_status[4]) && (@board_status[0].eql? @board_status[8]) ||
      (@board_status[2].eql? @board_status[4]) && (@board_status[2].eql? @board_status[6])
  end
end

class TicTacToe
  attr_reader :status, :turn

  def initialize
    @status = 'Ongoing'
    @turn = 1
  end

  def play
    board = Grid.new
    until @status == 'Ended'
      puts board
      puts "Please enter a position, #{player_decider} (Mark: #{mark_decider(player_decider)})"
      board.update(place_mark, mark_decider(player_decider))
      game_state?(board)
      @turn += 1
    end
    puts board
  end

  def game_state?(board)
    case board.finished?
    when 'WIN'
      puts "#{player_decider} has won!"
      @status = 'Ended'
    when 'FULL'
      puts 'You both have drawn!'
      @status = 'Ended'
    when 'NO'
      puts 'Brilliant move!'
    end
  end

  def player_decider
    if (@turn % 2).zero?
      'Player2'
    else
      'Player1'
    end
  end

  def mark_decider(player)
    if player == 'Player1'
      'X'
    else
      'O'
    end
  end

  def place_mark
    position = gets.chomp.to_i
    until (1..10).include?(position)
      puts 'Please enter a valid position on the board'
      position = gets.chomp.to_i
    end
    position
  end
end

game = TicTacToe.new
game.play
