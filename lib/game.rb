module SimpleQuest

  CORRIDOR_CONFIG = HashWithIndifferentAccess.new(YAML.load(File.read("./config/corridors.yml")))
  GEM_CONFIG = HashWithIndifferentAccess.new(YAML.load(File.read("./config/gems.yml")))
  GRUE_CONFIG = HashWithIndifferentAccess.new(YAML.load(File.read("./config/grues.yml")))
  PLAYER_CONFIG = HashWithIndifferentAccess.new(YAML.load(File.read("./config/players.yml")))
  ROOM_CONFIG = YAML.load(File.read("./config/rooms.yml")).map(&:with_indifferent_access)

  class Game

    def initialize
      map = Map.new(ROOM_CONFIG, CORRIDOR_CONFIG)
      player = Player.new
      grue = Grue.new
    end

  end

end