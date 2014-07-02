module SimpleQuest

  class Room

    attr_reader :name,
                :teleport
                :abbr

    def initialize
    end

    def self.teleport?(room_name)
      ROOM_CONFIG.select { |room| room[:name] == room_name.downcase.to_sym }.first[:teleport]
    end

  end

end