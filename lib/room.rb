module SimpleQuest

  class Room

    attr_accessor :name,
                  :teleport,
                  :gem,
                  :north,
                  :east,
                  :south,
                  :west

    def initialize(name, teleport, north=nil, east=nil, south=nil, west=nil)
      self.name = name
      self.teleport = teleport
      self.north = north
      self.east = east
      self.south = south
      self.west = west
    end

  end

end