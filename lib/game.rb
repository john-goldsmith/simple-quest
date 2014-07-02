module SimpleQuest

  GEM_CONFIG = HashWithIndifferentAccess.new(YAML.load(File.read("./config/gems.yml")))
  GRUE_CONFIG = HashWithIndifferentAccess.new(YAML.load(File.read("./config/grues.yml")))
  PLAYER_CONFIG = HashWithIndifferentAccess.new(YAML.load(File.read("./config/players.yml")))
  ROOM_CONFIG = YAML.load(File.read("./config/rooms.yml")).map(&:with_indifferent_access)

  class Game

    attr_accessor :player,
                  :grue,
                  :map,
                  :turns

    def initialize
      display_intro
      ensure_one_teleport_room
      self.map = Map.new
      self.player = Player.new
      self.grue = Grue.new
      start_game
    end

    def start_game
      player.display_current_room
      until won? && player.alive? do
        puts player.lives.inspect
        player.lives -= 1
        puts "Enter:"
        action = gets.chomp
      end
    end

    def display_intro
      Game.clear_screen
      puts "\nWelcome to...\n"
      puts '   _____ _                 __        ____                  __'
      puts '  / ___/(_)___ ___  ____  / /__     / __ \__  _____  _____/ /_'
      puts '  \__ \/ / __ `__ \/ __ \/ / _ \   / / / / / / / _ \/ ___/ __/'
      puts ' ___/ / / / / / / / /_/ / /  __/  / /_/ / /_/ /  __(__  ) /_'
      puts '/____/_/_/ /_/ /_/ .___/_/\___/   \___\_\__,_/\___/____/\__/'
      puts '                /_/'
      puts "\n"
    end

    def display_outro
      puts self.won? ? "You won!" : "You lost!"
    end

    def won?
      player.gems >= 5 && @player.current_room.teleport?
    end

    def ensure_one_teleport_room
      raise "At least one room needs to be configured as a teleport room (see config/rooms.yml)" if ROOM_CONFIG.all? { |room| room[:teleport] == false }
    end

    def self.clear_screen
      puts `clear` # TODO: This won't work on Windows
    end

  end

end