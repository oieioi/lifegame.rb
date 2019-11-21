require_relative "./life"

module Lifegame
  class Lifegame
    include Enumerable

    def initialize(x, y)
      @x = x
      @y = y
      @lifes = x.times.map { |x| y.times.map { |y| Life.new } }
      @generation = 0
    end

    def [](x, y)
      return nil if x.negative? || y.negative?
      return nil if x > @x || y > @y

      @lifes.fetch(x, []).fetch(y, nil)
    end

    def each
      @lifes.each.with_index { |line, x|
        line.each.with_index { |life, y|
          yield(life, x: x, y: y)
        }
      }
    end

    def next!
      self.
        # 調べて
        map { |_, point| { live: next_alive?(point[:x], point[:y]), x: point[:x], y: point[:y] } }.
        # 実施
        each do |life_point|
        x = life_point[:x]
        y = life_point[:y]

        if life_point[:live]
          self[x, y].be!
        else
          self[x, y].die!
        end
      end
      @generation += 1
    end

    # あるセルが次のターンに生きてるか確認する
    def next_alive?(x, y)
      target = self[x, y]

      # 隣接セルの座標
      adjoining = [
        [x - 1, y - 1],
        [x    , y - 1],
        [x + 1, y - 1],
        [x - 1, y],
        # [x    , y],
        [x + 1, y],
        [x - 1, y + 1],
        [x    , y + 1],
        [x + 1, y + 1],
      ]

      dead_or_live = adjoining.map { |point|
        n_x, n_y = point
        self[n_x, n_y]&.alive?
      }.compact

      live_count = dead_or_live.count { |live| live }

      if target.dead?
        # 3の時のみ誕生
        live_count == 3
      else
        # 2,3の時のみ生き残る
        (2..3).include?(live_count)
      end
    end

    def to_s
      lifes = @lifes.map { |line| line.map {|life| "#{life.to_s}"}.join }.join("\n")
      alives = count { |life| life.alive? }
      deads = count { |life| life.dead? }

      "generation: #{@generation}, x: #{@x}, y: #{@y}, all: #{@x * @y}, alive: #{alives}, dead: #{deads}\n#{lifes}"
    end

    def print
      # clear
      s = to_s
      puts "\e[H\e[2J"
      puts s
    end

    def start(wait_time = 0.1)
      loop {
        print
        sleep wait_time
        next!
      }
    rescue Interrupt
      puts 'good bye world!'
    end

    def sow!(alive_frequency = 0.2)
      self.each do |life, _point|
        if alive_frequency > rand
          life.be!
        end
      end
    end

    attr_reader :lifes
  end
end
