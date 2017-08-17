class TicTacToe
  def initialize(board = nil)
    @board = board || Array.new(9, " ")
  end

  WIN_COMBINATIONS =[
    [0,1,2], #Top row
    [3,4,5], #Middle row
    [6,7,8], #Bottom row
    [0,4,8], #Left to Right diagonals
    [2,4,6], #Right to Left diagonals
    [0,3,6], #First columns
    [1,4,7], #Second columns
    [2,5,8] #Third columns
  ]

  def display_board
    puts" #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts"-----------"
    puts" #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts"-----------"
    puts" #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def input_to_index(user_input)
    user_input.to_i - 1
  end

  def move(location, current_player = 'X')
    @board[location] = current_player
  end

  def position_taken?(location)
    @board[location] != " " && @board[location] != ""
  end

  def valid_move?(location)
    location.between?(0,8) && !position_taken?(location)
  end

  def turn
    puts "Please enter 1-9:"
    user_input = gets
    location = input_to_index(user_input)
    if valid_move?(location)
      move(location, current_player)
      display_board
    else
      turn
    end
  end

  def turn_count
     count = 0
     @board.each do |unit|
       if unit == "X" || unit == "O"
         count += 1
       end
     end
     return count
   end

   def current_player
     current_player = "X"
     if turn_count % 2 != 0
       current_player = "O"
     end
     return current_player
   end

   def won?
     WIN_COMBINATIONS.find do |win_index|
        (@board[win_index[0]] == "X" && @board[win_index[1]] == "X" && @board[win_index[2]] == "X") || (@board[win_index[0]] == "O" && @board[win_index[1]] == "O" && @board[win_index[2]] == "O")
      end
    end

    def full?
       @board.all?  { |position| (position == "X" || position == "O") }
     end

     def draw?
       if !won? && full?
         return true
       else
         return false
       end
     end

     def over?
       if won? || full? || draw?
         return true
       else
         return false
       end
     end

     def winner
       win = won?
       if win
         return @board[win[0]]
       end
     end

     def play
        while !over?
          turn
        end
        if won?
          puts "Congratulations #{winner}!"
        elsif draw?
          puts "Cat's Game!"
        end
      end
end
