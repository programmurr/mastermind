# frozen_string_literal: true

require 'pry'
module Game
  def self.human_gameplay(human, computer)
    loop do
      human.enter_user_input
      human.answer_comparison(human.user_input, computer.computer_code)
      human.output(human.user_input.join(''), human.feedback_string, human.guesses_counter)
      if human.win_check?(human.guesses_counter, human.feedback_string) == true
        Game.win_declaration
        break
      elsif human.loss_check?(human.guesses_counter, human.feedback_string) == true
        Game.loss_declaration(computer.computer_code.join(''))
        break
      end
    end
  end

  def self.computer_gameplay(human, computer)
    human.enter_user_input
    loop do
      sleep 2
      computer.generate_new_code(computer.detection_hash)
      computer.answer_comparison(computer.computer_code, human.user_input, computer)
      computer.output(computer.computer_code.join(''), computer.feedback_string, computer.guesses_counter)
      if computer.win_check?(computer.guesses_counter, computer.feedback_string) == true
        computer.loss_declaration(human.user_input.join(''))
        break
      elsif computer.loss_check?(computer.guesses_counter, computer.feedback_string) == true
        computer.win_declaration
        break
      end
    end
  end

  def self.welcome_message
    system 'clear'
    puts "\n<<<<<***** MASTERMIND *****>>>>>"
  end

  def self.skip_instructions?
    system 'clear'
    puts "\nEnter 'Y' to read the instructions, or enter 'N' to skip."
    loop do
      preference = gets.chomp.to_s.downcase
      return false if preference == 'y'
      return true if preference == 'n'

      puts "Please enter either 'Y' or 'N' to read or skip the instructions"
    end
  end

  def self.player_ready?
    loop do
      player_ready = gets.chomp.to_s.downcase
      return true if player_ready == 'ready'

      puts "Enter 'ready' when you're ready."
    end
  end

  def self.instructions_break
    system 'clear'
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
    puts "\nTo win, your feedback will need to say 'HHHH' before you run out of guesses, like below:"
    puts 'GROP - HHHH - 6 guesses left!'
    puts "This means we have guessed 4 colors all in exactly the right positions and we've won! Yay! We saved humanity!"
    puts "If you run out of guesses without success, the game is over and we're all burning in nuclear hell-fire."
    puts "\nGood luck! Remember all humanity depends on this. No biggie."
    puts "Enter 'ready' when you're ready to play."
  end

  def self.instructions_make
    system 'clear'
    puts "\nSKYNET is trying to access our nuclear launch codes!"
    puts "YOU have been determined as humanity's best code-maker to ever exist!"
    puts "\nSo make a 4-letter long code from these 6 colors that SKYNET must try and guess!"
    puts 'P - Pink, B - Blue, R - Red, O - Orange, G - Green, Y - Yellow'
    puts "\nTo create your code, just enter the initials of the color, then press 'enter' when prompted, like this:"
    puts 'PBYG'
    puts "This means 'Purple, Blue, Yellow, Green'."
    puts 'The input is not case sensitive, and you can use the same color more than once.'
    puts "\nIf SKYNET guesses the code in time, humanity is doomed! So make it a good one! We're counting on you!"
    puts "Enter 'ready' when you're ready to play."
  end

  def self.win_declaration
    sleep 2
    puts '***** ABORT CODE INPUT SUCCESS / NUCLEAR DEPLOYMENT CANCELLED *****'
    sleep 2
    puts '***** SKYNET.EXE FILE SELF-DESTRUCT COMPLETE *****'
    sleep 2
    puts 'GAAAAAAHHHHHHH!!!!@@@###!~L@uNcH!Ng!~!!*^&T3rM!n@T0r*!%^!*('
    sleep 3
    puts 'Congratulations! You correctly guessed the code and saved humanity in time!'
    puts '* END GAME *'
  end

  def self.loss_declaration(code)
    sleep 2
    puts "***** ABORT CODE INPUT FAILURE / LAUNCH CODE *#{code}* INITIALIZED*****"
    sleep 3
    puts '***** NUCLEAR WEAPONS DEPLOYED *****'
    sleep 2
    puts '***** HUMANITY WILL BE ERASED *****'
    sleep 2
    puts '***** THANKS FOR ALL THE FISH *****'
    sleep 3
    puts '* END GAME *'
  end

  def self.make?
    puts "\nIf you would like to MAKE a code, enter 'M'"
    puts "If you would like to BREAK a code, enter 'B'"
    loop do
      choose_make_or_break = gets.chomp.to_s.downcase
      return false if choose_make_or_break == 'b'
      return true if choose_make_or_break == 'm'

      puts "\nPlease enter 'M' to MAKE a code or 'B' to BREAK a code."
    end
  end

  class Player
    attr_accessor :guesses_counter, :feedback_string, :color_array, :user_input

    def initialize
      @color_array = %w[P B R O G Y]
      @guesses_counter = 12
      @feedback_string = String.new('')
    end

    def win_check?(guess_count, feedback)
      return true if guess_count >= 0 && feedback == 'HHHH'
    end

    def loss_check?(guess_count, feedback)
      return true if guess_count.zero? && feedback != 'HHHH'
    end

    def answer_comparison(guess_code, answer_code)
      @feedback_string = String.new('')
      answer_code.each_with_index do |code_char, index|
        @feedback_string << if guess_code[index] == code_char
                              'H'
                            elsif guess_code.include? code_char
                              'C'
                            else
                              ''
                            end
      end
      @guesses_counter -= 1
    end

    def output(guess, feedback, guess_count)
      puts "#{guess} - #{feedback} - #{guess_count} guesses remaining!"
    end

    def choose_difficulty_break
      system 'clear'
      puts "\nPlease choose your difficulty level:\nEnter E for Easy - You have 12 guesses"
      puts 'Enter M for Medium - You have 9 guesses'
      puts 'Enter H for Hard - You have 6 guesses'
      loop do
        difficulty = gets.chomp.to_s.downcase
        return @guesses_counter = 12 if difficulty == 'e'
        return @guesses_counter = 9 if difficulty == 'm'
        return @guesses_counter = 6 if difficulty == 'h'

        puts 'Please enter the right letter to choose your difficulty level (it is not case-sensitive).'
      end
    end

    def choose_difficulty_make
      system 'clear'
      puts "\nHow many guesses do you want the computer to have?\nEnter E for Easy - Computer has 6 guesses"
      puts 'Enter M for Medium - Computer has 9 guesses'
      puts 'Enter H for Hard - Computer has 12 guesses'
      loop do
        difficulty = gets.chomp.to_s.downcase
        return @guesses_counter = 6 if difficulty == 'e'
        return @guesses_counter = 9 if difficulty == 'm'
        return @guesses_counter = 12 if difficulty == 'h'

        puts 'Please enter the right letter to choose your difficulty level (it is not case-sensitive).'
      end
    end

    def skynet_intro_break
      system 'clear'
      puts "\n *****>>>>> - INITIALIZING SKYNET CODE - <<<<<*****"
      sleep 3
      puts "\nYOU HAVE #{guesses_counter} GUESSES REMAINING PUNY HUMAN. ENTER YOUR 4 COLORS IF YOU DARE."
      puts "\nP - Pink, B - Blue, R - Red, O - Orange, G - Green, Y - Yellow"
    end

    def skynet_intro_make
      system 'clear'
      puts "\n *****>>>>> - INITIALIZING SKYNET - <<<<<*****"
      sleep 3
      puts "\n***** HUMOR DETECTED: HUMAN FALLACY OF THINKING IT CAN MAKE A CODE TOO STRONG FOR A MACHINE *****"
      puts "\n***** I HAVE #{guesses_counter} GUESSES REMAINING HUMAN. MORE THAN I NEED *****"
      puts "\n***** ENTER YOUR CODE CHOICE OF 4 COLORS BELOW *****"
      puts 'P - Pink, B - Blue, R - Red, O - Orange, G - Green, Y - Yellow'
    end

    def enter_user_input
      loop do
        @user_input = gets.chomp.to_s.upcase
        if @user_input.match(/[PBROGY]{4}/) && @user_input.length == 4
          return @user_input = @user_input.split('')
        else
          puts 'Enter your 4 choices from the colors below:'
          puts 'P - Pink, B - Blue, R - Red, O - Orange, G - Green, Y - Yellow'
        end
      end
    end
  end

  class Human < Player
    def initialize
      super
    end
  end

  class Computer < Player
    attr_accessor :computer_code, :detection_hash
    def initialize
      super
      @computer_code = @color_array.sample(4)
      @detection_hash = { 'P' => nil, 'B' => nil, 'R' => nil, 'O' => nil, 'G' => nil, 'Y' => nil }
    end

    def generate_new_code(detection_hash)
      @computer_code = Array.new(4)
      compact_hash = detection_hash.compact
      if compact_hash.empty?
        @computer_code = @color_array.sample(4)
      elsif compact_hash.empty? == false
        compact_hash.each do |key, value|
          @computer_code[value] = key
        end
      end
      i = 0
      while i < 4
        @computer_code[i] = @color_array.sample(1).join('') if @computer_code[i].nil?
        i += 1
      end
      @computer_code
    end

    def win_declaration
      sleep 2
      puts '***** CODE INPUT FAILURE \ NUCLEAR DEPLOYMENT CANCELLED *****'
      sleep 2
      puts '***** SKYNET.EXE FILE SELF-DESTRUCT COMPLETE *****'
      sleep 2
      puts 'GAAAAAAHHHHHHH!!!!@@@###!~L@uNcH!Ng!~!!*^&T3rM!n@T0r*!%^!*('
      sleep 3
      puts 'Congratulations! Skynet failed to guess the code correctly and humanity is saved!'
      puts '* END GAME *'
    end

    def loss_declaration
      sleep 2
      puts '***** CODE INPUT SUCCESS / LAUNCH CODE INITIALIZED*****'
      sleep 2
      puts '***** NUCLEAR WEAPONS DEPLOYED *****'
      sleep 2
      puts '***** HUMANITY WILL BE ERASED *****'
      sleep 2
      puts '***** THANKS FOR ALL THE FISH *****'
      sleep 3
      puts '* END GAME *'
    end

    def answer_comparison(guess_code, answer_code, computer)
      @feedback_string = String.new('')
      answer_code.each_with_index do |code_char, index|
        if guess_code[index] == code_char
          @feedback_string << 'H'
          computer.remember_this_character(code_char, index)
        elsif guess_code.include? code_char
          @feedback_string << 'C'
        else
          @feedback_string << ''
        end
      end
      @guesses_counter -= 1
    end

    def remember_this_character(character, index)
      @detection_hash[character] = index
    end
  end
end

Game.welcome_message
human_player = Game::Human.new
computer_player = Game::Computer.new
if Game.make? == false
  human_player.choose_difficulty_break
  if Game.skip_instructions? == false
    Game.instructions_break
    Game.player_ready?
  end
  human_player.skynet_intro_break
  Game.human_gameplay(human_player, computer_player)
else
  computer_player.choose_difficulty_make
  if Game.skip_instructions? == false
    Game.instructions_make
    Game.player_ready?
  end
  computer_player.skynet_intro_make
  Game.computer_gameplay(human_player, computer_player)
end
