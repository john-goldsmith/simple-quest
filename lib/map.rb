module SimpleQuest

  class Map

    attr_accessor :rooms

    def initialize
      self.rooms = []
      ROOM_CONFIG.each do |room|
        self.rooms << Room.new(room[:name], room[:teleport], room[:north], room[:east], room[:south], room[:west])
      end
    end

    def ensure_one_teleport_room
      if ROOM_CONFIG.all? { |room| !room[:teleport] }
        rooms.sample.teleport = true
      end
    end

    def self.display
      Game.clear_screen
      map = File.open("./docs/map.txt", "rb")
      puts map.read
      map.close
    end

    def teleports
      rooms.select { |room| room.teleport == true }
    end

  end

end