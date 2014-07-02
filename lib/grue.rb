module SimpleQuest

  class Grue

    attr_accessor :room,
                  :gems

    def initialize
      self.room = ROOM_CONFIG.sample[:name] # TODO: Don't spawn in the same room as the player
    end

    def flee
    end

    def drop_gem
      if GRUE_CONFIG[:starting_gems] >= 0 # Not unlimited
        self.gems -= 1 if self.gems > 0
      end
    end

    def attack
    end

  end

end