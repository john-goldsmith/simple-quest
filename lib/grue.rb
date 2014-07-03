module SimpleQuest

  class Grue

    DIRECTIONS = ["north", "east", "south", "west"]

    attr_reader :room

    def initialize(rooms)
      @room = rooms.sample
      @gems = GRUE_CONFIG[:starting_gems]
    end

    def ensure_has_enough_gems
    end

    def flee(map)
      drop_gem
      move(map)
    end

    def move(map)
      outbound_room = @room.send(DIRECTIONS.sample)
      if outbound_room.nil?
        move(map)
      else
        @room = map.find_room_by_name(outbound_room)
      end
    end

    def drop_gem
      @gems -= 1 if has_gems?
    end

    def has_gems?
      @gems != 0
    end

  end

end