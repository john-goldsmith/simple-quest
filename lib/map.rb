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

    def teleport_rooms
      rooms.select { |room| room.teleport == true }
    end

    def gem_rooms
      rooms.select { |room| room.gem == true }
    end

    def scatter_gems
      rooms.sample(GEM_CONFIG[:goal].to_i).each { |room| room.gem = true }
    end

    def find_room_by_name(name)
      rooms.select { |room| room.name == name }.first
    end

  end

end