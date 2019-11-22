module Lifegame
  class Life
    ALIVE = '-'
    DEAD = '_'

    def initialize(life = false)
      @life = life
    end

    def to_s
      alive? ? ALIVE : DEAD
    end

    def alive?
      @life
    end

    def dead?
      not alive?
    end

    def die!
      @life = false
    end

    def be!
      @life = true
    end
  end
end
