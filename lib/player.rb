module SimpleQuest

  class Player

    attr_accessor :name,
                  :gems,
                  :room,
                  :lives,
                  :turn

    def initialize(rooms)
      self.lives = PLAYER_CONFIG[:lives]
      self.gems = PLAYER_CONFIG[:starting_gems]
      self.room = rooms.sample
      self.turn = 1
      # prompt_for_name
    end

    # def prompt_for_name
    #   Game.display_divider "Your Name"
    #   print "To begin, please enter your name: "
    #   self.name = gets.chomp
    # end

    def move(map, direction)
      outbound_room = room.send(direction)
      if outbound_room.nil?
        puts "There is no outbound corridor heading #{direction}. Try a different direction."
      else
        self.room = map.find_room_by_name(outbound_room)
        collect_gem if self.room.gem
        puts "You are now in the #{self.room.name.titleize} room."
        increment_turn
      end
      # puts "Resting..." if resting?
    end

    def alive?
      self.lives > 0
    end

    def dead?
      self.lives <= 0
    end

    def resting?
      self.turn % PLAYER_CONFIG[:rest_every_n_turns] == 0
    end

    def decrement_life
      self.lives -= 1 if self.lives > 0
    end

    def increment_turn
      self.turn += 1
    end

    def collect_gem
      self.gems += 1
    end

  end

end