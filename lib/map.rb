module SimpleQuest

  class Map

    attr_accessor :rooms

    def initialize
      self.rooms = []
      ROOM_CONFIG.each do |room|
        self.rooms << room
      end
    end

    def set_teleport
    end

    def self.display
      Game.clear_screen
      map = File.open("./docs/map.txt", "rb")
      puts map.read
      map.close
    end

  end

end