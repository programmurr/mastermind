# frozen_string_literal: true

module Game
  def self.start_game
    Game.welcome_message
    if Game.skip_instructions? == false
      Game.instructions
      Game.player_ready?
    end
  end

  def self.gameplay(human, computer)
    loop do
      # clear feedback string
      human.enter_user_answer
      human.answer_comparison(human.user_guess, computer.computer_code)
      human.output(human.user_guess, human.feedback_string, human.guesses_counter)
      if human.win_check?(human.guesses_counter, human.feedback_string) == true
        Game.win_declaration
        break
      elsif human.loss_check?(human.guesses_counter, human.feedback_string) == true
        Game.loss_declaration(computer.computer_code.join(''))
        break
      end
    end
  end

  def self.welcome_message
    puts 'Hello! Welcome to'
    puts '<<<<<***** MASTERMIND *****>>>>>'
    puts "If you've played before, you can skip the instructions."
    puts "Enter 'yes' if you would like to read them, or enter 'no' to skip them."
  end

  def self.skip_instructions?
    loop do
      preference = gets.chomp.to_s.downcase
      return false if preference == 'yes'
      return true if preference == 'no'

      puts "Please enter either 'yes' or 'no' to read or skip the instructions"
    end
  end

  def self.player_ready?
    loop do
      player_ready = gets.chomp.to_s.downcase
      return true if player_ready == 'ready'

      puts "Enter 'ready' when you're ready."
    end
  end

  def self.instructions
    puts "\nSKYNET is awake and getting ready to launch its nukes all up in our faces!"
    puts "For some reason, YOU are humanity's last hope and must try to input the abort code to stop the launch and save us all!"
    puts "\nSKYNET will choose up to 4 of 6 colors to make a code. It might use the same color more than once!"
    puts 'The colors it can choose from are: P - Pink, B - Blue, R - Red, O - Orange, G - Green, Y - Yellow.'
    puts "You need to guess which color SKYNET chooses and the order it puts them in it's code."
    puts "\nEnter your guess by entering the initials of the colors. To guess 'Yellow, Blue, Orange, Green', type:"
    puts "'YBOG' then press enter (the input is not case-sensitive)."
    puts 'Easy! You will also receive feedback after every guess.'
    puts "'H' means 'HIT!' - meaning that you have guessed one correct color that is in the correct place."
    puts "'C' means 'CLOSE!' - meaning you have guessed one correct color but it's in the wrong place."
    puts 'No feedback is given if one or all of your guesses are wrong.'
    puts "\nSo after you enter your guess, you will see this:"
    puts 'YBOG - HC - 11 guesses left!'
    puts "'YBOG' is your guess. 'HC' is the feedback. '11 guesses left' is...well, it's how many guesses are left!"
    puts 'We guessed one color in the right place, one color in the wrong place, and our two other guesses were completely wrong.'
    puts "\nTo win, your feedback will need to say 'HHHH' in 12 guesses or less, like below:"
    puts 'GROP - HHHH - 6 guesses left!'
    puts "This means we have guessed 4 colors all in exactly the right positions and we've won! Yay! We saved humanity!"
    puts "If you run out of guesses without success, the game is over and we're all burning in nuclear hell-fire."
    puts "\nGood luck! Remember all humanity depends on this. No biggie."
    puts "Enter 'ready' when you're ready to play."
  end

  def self.win_declaration
    puts '***** ABORT CODE INPUT SUCCESS *****'
    sleep 2
    puts '***** NUCLEAR DEPLOYMENT CANCELLED *****'
    sleep 2
    puts '***** SKYNET.EXE FILE SELF-DESTRUCT COMPLETE *****'
    sleep 2
    puts 'GAAAAAAHHHHHHH!!!!@@@###!~!~!!*^&*!%^!*('
    sleep 3
    puts 'Congratulations! You correctly guessed the code and saved humanity in time!'
    puts '* END GAME *'
  end

  def self.loss_declaration(code)
    puts '***** ABORT CODE INPUT FAILURE *****'
    sleep 2
    puts "***** LAUNCH CODE #{code} INITIALIZED*****"
    sleep 2
    puts '***** NUCLEAR WEAPONS DEPLOYED *****'
    sleep 2
    puts '***** HUMANITY WILL BE ERASED *****'
    sleep 2
    puts '***** THANKS FOR ALL THE FISH *****'
    sleep 3
    puts '* END GAME *'
  end

  class Player
    @@color_array = %w[P B R O G Y P B R O G Y P B R O G Y P B R O G Y]

    def self.access_color_array
      @@color_array
    end
  end
  class Human < Player
    include Game
    attr_accessor :guesses_counter, :user_guess, :feedback_string
    def initialize
      @guesses_counter = 12
      @feedback_string = String.new('')
    end

    def enter_user_answer
      loop do
        @user_guess = gets.chomp.to_s.upcase
        if @user_guess.match(/[PBROGY]{4}/) && @user_guess.length == 4
          return @user_guess.split('')
        else
          puts 'Please enter your 4 choices from the colors below:'
          puts 'P - Pink, B - Blue, R - Red, O - Orange, G - Green, Y - Yellow'
        end
      end
    end

    def win_check?(guess_count, feedback)
      return true if guess_count.positive? && feedback == 'HHHH'
    end

    def loss_check?(guess_count, feedback)
      return true if guess_count.zero? && feedback != 'HHHH'
    end

    def answer_comparison(human_guess, computer_code)
      @feedback_string = String.new('')
      computer_code.each_with_index do |code_char, index|
        if human_guess[index] == code_char
          @feedback_string << 'H'
        elsif human_guess.include? code_char
          @feedback_string << 'C'
        end
      end
      @guesses_counter -= 1
    end

    def output(guess, feedback, guess_count)
      puts "#{guess} - #{feedback} - #{guess_count} guesses remaining!"
    end
  end
  class Computer < Player
    attr_accessor :computer_code
    def initialize
      @computer_code = Player.access_color_array.sample(4)
      puts "\n *****>>>>> - INITIALIZING SKYNET CODE - <<<<<*****"
      sleep 3
      puts "\nYOU HAVE 12 GUESSES REMAINING PUNY HUMAN. ENTER YOUR 4 COLORS IF YOU DARE."
      puts "\nP - Pink, B - Blue, R - Red, O - Orange, G - Green, Y - Yellow"
    end
  end
end

Game.start_game
computer_player = Game::Computer.new
human_player = Game::Human.new
Game.gameplay(human_player, computer_player)
