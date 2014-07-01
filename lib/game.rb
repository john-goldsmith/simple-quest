module SimpleQuest

  GEM_CONFIG = HashWithIndifferentAccess.new(YAML.load(File.read("./config/gems.yml")))
  GRUE_CONFIG = HashWithIndifferentAccess.new(YAML.load(File.read("./config/grues.yml")))
  PLAYER_CONFIG = HashWithIndifferentAccess.new(YAML.load(File.read("./config/players.yml")))
  ROOM_CONFIG = YAML.load(File.read("./config/rooms.yml")).map(&:with_indifferent_access)

  class Game

    def initialize
      display_intro
      @map = Map.new(ROOM_CONFIG)
      @player = Player.new
      puts @player.name.inspect
      @grue = Grue.new
    end

    def display_intro
      puts "Welcome to Simple Quest!"
    end

  end

end