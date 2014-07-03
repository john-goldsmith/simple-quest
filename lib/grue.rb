module SimpleQuest

  class Grue

    DIRECTIONS = ["north", "east", "south", "west"]

    attr_accessor :room,
                  :gems

    def initialize(rooms)
      self.room = rooms.sample
    end

    def flee(map)
      drop_gem
      move(map)
    end

    def move(map)
      outbound_room = room.send(DIRECTIONS.sample)
      if outbound_room.nil?
        move(map)
      else
        self.room = map.find_room_by_name(outbound_room)
      end
    end

    def drop_gem
      if GRUE_CONFIG[:starting_gems] >= 0 # Not unlimited
        self.gems -= 1 if self.gems > 0
      end
    end

    # def attack
    # end

  end

end