module SimpleQuest

  class Grue

    def initialize
      @room = ROOM_CONFIG.sample[:name] # TODO: Don't spawn in the same room as the player
    end

    def flee
    end

    def drop_gem
    end

    def attack
    end

  end

end