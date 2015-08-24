# class Player
#     #has an instance of a ScoreCard
# end

# class ScoreCard

# end

class Game

    def dice
    (1..6).to_a.sample
    end

    def dice_rolls(roll_array = [])
    (5-roll_array.length).times do
        roll_array << dice
    end
    return roll_array
    end

    def dice_to_keep
    print 'Input which dice you would like to keep: '
    user_input = gets.chomp
    user_input.split(' ').map(&:to_i)
    end

    def turn
        stored_roll = dice_rolls
        print stored_roll
        i = 0
        while i < 2
            puts "\nWould you like to roll again? 1: Yes 2: No"
            user_choice = gets.chomp
            if user_choice == '1'
                stored_roll = dice_rolls(dice_to_keep)
                puts "New roll: #{stored_roll}"
                i += 1
            else
                i = 2
            end
        end
        puts "#{stored_roll}"
        return stored_roll
    end
end
