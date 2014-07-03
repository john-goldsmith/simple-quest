module SimpleQuest

  class Room

    attr_reader :name,
                :teleport,
                :gem,
                :north,
                :east,
                :south,
                :west

    def initialize(name, teleport, north=nil, east=nil, south=nil, west=nil)
      @name = name
      @teleport = teleport
      @north = north
      @east = east
      @south = south
      @west = west
    end

  end

end