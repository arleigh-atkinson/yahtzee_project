class Player
  attr_accessor :name, :scorecard, :total_score

  def initialize(name, score)
    @name = name
    @scorecard = score
    @total_score = 0
  end

  def calculate_score

  end
end

class ScoreCard

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

  def display_options
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

  def player_choice(user_array)
    puts "Choose a scoring option: "
    choice = gets.chomp
    case choice
    when 'aces'
      upper_section_scoring(1, user_array)
    when 'twos'
      upper_section_scoring(2, user_array)
    when 'threes'
      upper_section_scoring(3, user_array)
    when 'fours'
      upper_section_scoring(4, user_array)
    when 'fives'
      upper_section_scoring(5, user_array)
    when 'sixes'
      upper_section_scoring(6, user_array)
    when 'three_of_a_kind'
      sum_die(user_array)
    when 'four_of_a_kind'
      sum_die(user_array)
    when 'full_house'
      25
    when 'small_straight'
      30
    when 'large_straight'
      40
    when 'yahtzee'
      50
    when 'chance'
      sum_die(user_array)
    end
  end

  def upper_section_scoring(number, arr)
    arr.count(number) * number
  end

  def sum_die(arr)
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
main = Game.turn
