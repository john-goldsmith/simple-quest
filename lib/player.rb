module SimpleQuest

  class Player

    attr_accessor :gems,
                  :room
    attr_reader :turn,
                :lives

    def initialize(rooms)
      @lives = PLAYER_CONFIG[:lives]
      @gems = PLAYER_CONFIG[:starting_gems]
      @room = rooms.sample
      @turn = 1
      # prompt_for_name
    end

    # def prompt_for_name
    #   Game.display_divider "Your Name"
    #   print "To begin, please enter your name: "
    #   @name = gets.chomp
    # end

    def move(map, direction)
      outbound_room = @room.send(direction)
      if outbound_room.nil?
        puts "There is no outbound corridor heading #{direction}. Try a different direction."
      else
        @room = map.find_room_by_name(outbound_room)
        collect_gem if @room.gem
        puts "You are now in the #{@room.name.titleize} room."
        increment_turn
      end
    end

    def dead?
      @lives <= 0
    end

    def resting?
      @turn.modulo(PLAYER_CONFIG[:rest_every_n_turns]).zero?
    end

    def decrement_life
      @lives -= 1 if @lives > 0
    end

    def increment_turn
      @turn += 1
    end

    def collect_gem
      @gems += 1
    end

  end

end