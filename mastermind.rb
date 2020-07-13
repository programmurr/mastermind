# frozen_string_literal: true

module Game
  def self.start_game
    Game.welcome_message
    if Game.skip_instructions? == false
      Game.instructions
      Game.player_ready?
    end
  end

  def self.gameplay(human, _computer)
    human.enter_user_answer
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
    puts 'SKYNET is awake and getting ready to launch its nukes all up in our faces!'
    puts 'You must guess its super secret code to deactivate it and disable all the nuclear bombs, saving humanity!'
    puts 'SKYNET will choose up to 4 of 6 colors to make a code. It might use the same color more than once!'
    puts 'The colors it can choose from are: P - Pink, B - Blue, R - Red, O - Orange, G - Green, Y - Yellow.'
    puts 'You need to guess which color SKYNET will put and in what order it puts them.'
    puts "Enter your guess by entering the initials of the colors. To guess 'Yellow, Yellow, Blue, Blue', type:"
    puts "'YYBB' then press enter."
    puts 'Easy! You will also receive feedback after every guess.'
    puts "'W' means 'White' - meaning that you have guessed one correct color that is in the correct place."
    puts "'B' means 'Black' - meaning you have guessed one correct color but it's in the wrong place."
    puts 'No feedback is given if one or all of your guesses are wrong.'
    puts 'So after you enter your guess, you will see this:'
    puts 'YYBB - WB - 11 guesses left!'
    puts "'YYBB' is your guess. 'WB' is the feedback. '11 guesses left' is...well, it's how many guesses are left!"
    puts 'We guessed one color in the right place, one color in the wrong place, and our two other guesses were completely wrong.'
    puts "To win, your feedback will need to say 'WWWW' in 12 guesses or less, like below:"
    puts 'BYGO - WWWW - 6 guesses left!'
    puts "This means we have guessed 4 colors all in exactly the right positions and we've won! Yay! We saved humanity!"
    puts "If you run out of guesses without success, the game is over and we're all burning in nuclear fire."
    puts 'Good luck! Remember all humanity depends on this. No biggie.'
    puts "Enter 'ready' when you're ready to play."
  end

  def self.win_declaration; end

  def loss_declaration; end
  class Player
    @@color_array = %w[P B R O G Y]

    def self.access_color_array
      @@color_array
    end
  end
  class Human < Player
    include Game
    attr_accessor :guesses_counter, :user_guess, :feedback_array
    def initialize
      @guesses_counter = 12
      @feedback_string = ''
    end

    def enter_user_answer
      loop do
        user_entry = gets.chomp.to_s.upcase
        if user_entry.match(/[PBROGY]{4}/) && user_entry.length == 4
          return p user_entry.split('')
        else
          puts 'Please enter your 4 choices from the colors below:'
          puts 'P - Pink, B - Blue, R - Red, O - Orange, G - Green, Y - Yellow'
        end
      end
      # @user_guess = gets.chomp.to_s.upcase.split('')
      # make sure it is only letters, no numbers or special characters
    end

    def win_check(guess_count, feedback)
      # if guess_count > 0 and feedback == 'WWWW'
      # - Game.win_declaration
    end

    def another_turn?(guess_count, feedback)
      # if guess_count > 0 and feedback != 'WWWW'
      # return true
    end

    def loss_check(guess_count, feedback)
      # if guess_count == 0 and feedback != 'WWWW'
      # - Game.loss_declaration
    end

    def answer_comparison; end

    def output(guess, feedback, guess_count)
      # @user_guess_output = human_player.user_guess.join('')
      # puts "#{user_guess_output} - #{feedback} - #{guess_count} guesses left!"
    end
  end
  class Computer < Player
    attr_accessor :computer_code
    def initialize
      @computer_code = Player.access_color_array.sample(4)
      puts "\n #####*****>>>>> - INITIALIZING SKYNET CODE - <<<<<*****#####"
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

# Code flow:
# Game.start_game*
# - Game.welcome_message*
# - Game.skip_instructions?*
# - Game.instructions
# computer_player = Computer.new (generates computer code)
# human_player = Human.new
# Game.gameplay (all below is controlled by gameplay?)
# human_player.enter_user_answer
# human_player.answer_comparison
# human_player.output(human_player.user_guess, human_player.feedback_array, human_player.guesses_counter)
# human_player.win_check
# - if win:
# - - Game.win_declaration
# human_player.another_turn_check
# - if turns left and no win:
# - - go back to human_player.enter_user_answer(gets.chomp.to_s.upcase.split(''))
# human_player.loss_check
# - if no turns left and no win:
# - - Game.loss_delaration

# * pseudocode needs planned
