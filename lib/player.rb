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
      Game.display_divider "Your Name"
      print "To begin, please enter your name: "
      self.name = gets.chomp
    end

    def move(cardinal_direction)

    end

    def alive?
      lives > 0
    end

    def dead?
      lives <= 0
    end

    def rest
    end

    def decrement_life
      self.lives -= 1
    end

  end

end