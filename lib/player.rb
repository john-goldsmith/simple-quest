module SimpleQuest

  class Player

    attr_accessor :name,
                  :gems,
                  :room,
                  :lives

    def initialize
      self.lives = PLAYER_CONFIG[:lives]
      self.gems = PLAYER_CONFIG[:starting_gems]
      self.room = ROOM_CONFIG.sample
      prompt_for_name
    end

    def prompt_for_name
      puts "To begin, please enter your name:\n\n"
      self.name = gets.chomp
    end

    def move(cardinal_direction)
    end

    def alive?
      lives > 0
    end

    def display_current_room
      puts "You are currently in the #{self.room[:name].titleize} room."
    end

    def rest
    end

  end

end