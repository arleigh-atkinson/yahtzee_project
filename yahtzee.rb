require 'pry'



class Player
  attr_accessor :name, :scorecard, :total_score

  def initialize(name)
    @name = name
    @scorecard = ScoreCard.new
    @total_score = 0
  end

  def self.calculate_score
    # temp = ScoreCard.player_choice(Game.turn)
    # @total_score += temp
  end
end

class ScoreCard

  #attr_accessor :scorecard_options

  @scorecard = {
    upper_section: {
      aces: 0,
      twos: 0,
      threes: 0,
      fours: 0,
      fives: 0,
      sixes: 0
    },
    lower_section: {
      three_of_a_kind: 0,
      four_of_a_kind: 0,
      full_house: 0,
      small_straight: 0,
      large_straight: 0,
      yahtzee: 0,
      chance: 0
    }
  }

  @scorecard_options = {
    upper_section: {
      aces: 'Total of aces only',
      twos: 'Total of twos only',
      threes: 'Total of threes only',
      fours: 'Total of fours only',
      fives: 'Total of fives only',
      sixes: 'Total of sixes only'
    },
    lower_section: {
      three_of_a_kind: 'Total of all five dice',
      four_of_a_kind: 'Total of all five dice',
      full_house: 'Score 25',
      small_straight: 'Score 30',
      large_straight: 'Score 40',
      yahtzee: 'Score 50',
      chance: 'Total dice'
    }
  }

  def self.display_options
    puts """Scoring Options:
    Upper Section:
    option            description
    ------------------------------------
    """
    @scorecard_options[:upper_section].each do |key, value|
      puts "\t#{key}     #{value}"
    end
    puts """
    Lower Section:
    option            description
    ------------------------------------
    """
    @scorecard_options[:lower_section].each do |key, value|
      puts "\t#{key}     #{value}"
    end
  end

  def self.player_choice(user_array)
    display_options
    puts "Choose a scoring option: "
    choice = gets.chomp
    case choice
    when 'aces'
      @scorecard_options[:upper_section].delete(:aces)
      upper_section_scoring(1, user_array)
      #binding.pry
    when 'twos'
      @scorecard_options[:upper_section].delete(:twos)
      upper_section_scoring(2, user_array)
    when 'threes'
      @scorecard_options[:upper_section].delete(:threes)
      upper_section_scoring(3, user_array)
    when 'fours'
      @scorecard_options[:upper_section].delete(:fours)
      upper_section_scoring(4, user_array)
    when 'fives'
      @scorecard_options[:upper_section].delete(:fives)
      upper_section_scoring(5, user_array)
    when 'sixes'
      @scorecard_options[:upper_section].delete(:sixes)
      upper_section_scoring(6, user_array)
    when 'three_of_a_kind'
      @scorecard_options[:lower_section].delete(:twos)
      sum_die(user_array)
    when 'four_of_a_kind'
      @scorecard_options[:lower_section].delete(:four_of_a_kind)
      sum_die(user_array)
    when 'full_house'
      @scorecard_options[:lower_section].delete(:full_house)
      25
    when 'small_straight'
      @scorecard_options[:lower_section].delete(:small_straight)
      30
    when 'large_straight'
      @scorecard_options[:lower_section].delete(:large_straight)
      40
    when 'yahtzee'
      @scorecard_options[:lower_section].delete(:yahtzee)
      50
    when 'chance'
      @scorecard_options[:lower_section].delete(:chance)
      sum_die(user_array)
    end
  end

  def self.upper_section_scoring(number, arr)
    arr.count(number) * number
  end

  def self.sum_die(arr)
    arr.inject(:+)
  end
end

class Game

  def self.dice
    (1..6).to_a.sample
  end

  def self.dice_rolls(roll_array = [])
    (5-roll_array.length).times do
      roll_array << dice
    end
    return roll_array
  end

  def self.dice_to_keep
    print 'Input which dice you would like to keep: '
    user_input = gets.chomp
    user_input.split(' ').map(&:to_i)
  end

  def self.turn
    stored_roll = dice_rolls
    print stored_roll
    2.times do
      puts "\nWould you like to roll again? 1: Yes 2: No"
      user_choice = gets.chomp
      if user_choice == '1'
        stored_roll = dice_rolls(dice_to_keep)
        puts "New roll: #{stored_roll}"
      end
      break if user_choice == '2'
    end
    puts "#{stored_roll}"
    stored_roll
  end
end


## MAIN PROGRAM ##
puts 'Welcome to ~Yahtzee~'
loop do
  puts 'Would you like to play Yahtzee? 1: Yes 2: No'
  play_yahtzee = gets.chomp
  break if play_yahtzee == '2'
  if play_yahtzee == '1'
    player_hash = {}
    puts 'How many are playing?'
    number_of_players = gets.chomp.to_i
    # loop through to get array of player names
    number_of_players.times do 
      print 'Please type your name: '
      player_name = gets.chomp
      player_hash[player_name] = Player.new(player_name)
    end

    # loop through turns
    turns_taken = 0
    while number_of_players*13 - turns_taken > 0
      player_hash.each_pair do |key, value|
        temp = ScoreCard.player_choice(Game.turn)
        player_hash[key].total_score += temp
        puts "#{temp} points! Total score: ", player_hash[key].total_score
        binding.pry
      end  
      turns_taken += 1  
    end
  end
end





