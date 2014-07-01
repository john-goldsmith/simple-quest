module SimpleQuest

  class Player

    attr_accessor :name

    def initialize
      prompt_for_name
    end

    def prompt_for_name
      puts "To begin, please enter your name: "
      self.name = gets.chomp
    end

  end

end