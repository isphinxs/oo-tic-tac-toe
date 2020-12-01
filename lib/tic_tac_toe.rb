class TicTacToe

    attr_accessor :board

    WIN_COMBINATIONS = [
        [0, 1, 2], # top row
        [3, 4, 5], # middle horizontal row
        [6, 7, 8], # bottom row
        [0, 3, 6], # left row
        [1, 4, 7], # middle vertical row
        [2, 5, 8], # right row
        [0, 4, 8], # top-left slash
        [2, 4, 6] # top-right slash
    ]

    def initialize
        @board = Array.new(9, " ")
    end

    def display_board
        puts " #{@board[0]} | #{@board[1]} | #{@board[2]} \n
        -----------\n
         #{@board[3]} | #{@board[4]} | #{@board[5]} \n
         -----------\n
         #{@board[6]} | #{@board[7]} | #{@board[8]} "
    end

    def input_to_index(input)
        input.to_i - 1
    end

    def move(index, token = "X")
        @board[index] = token
    end

    def position_taken?(index)
        @board[index] == " " ? false : true
    end

    def valid_move?(position)
        if position >= 0 && position <= 8 && !position_taken?(position)
            true
        else
            false
        end
    end

    def turn
        puts "Please enter 1-9"
        input = gets.chomp
        index = input_to_index(input)
        until valid_move?(index) 
            puts "Please enter 1-9"
            input = gets.chomp
            index = input_to_index(input)
        end
        move(index, current_player)
        display_board
    end

    def turn_count
        @board.count {|position| position != " " }
    end

    def current_player
        turn_count % 2 == 0 ? "X" : "O"
    end

    def won?
        outcome = WIN_COMBINATIONS.select do |combo|
            @board[combo[0]] != " " && @board[combo[0]] == @board[combo[1]] && @board[combo[1]] == @board[combo[2]]
        end 
        outcome == [] ? false : outcome.flatten
    end

    def full?
        !@board.include?(" ")
    end

    def draw?
        if full? && !won?
            true
        else 
            false
        end 
    end

    def over?
        true if won? || draw?
    end

    def winner
        winning_combo = won?
        winning_combo ? @board[winning_combo[0]] : nil
    end

    def play
        
        until over? do 
            turn
            turn_count
        end
        
        puts "testing"
        if won?
            puts "Congratulations #{winner}!"
        elsif full?
            puts "Cat's Game!"
        end

    end

end 