require "lifegame/version"
require "lifegame/lifegame"

module Lifegame
  class Error < StandardError; end
  def self.demo(size_x = 10, size_y = 100, frequency = 0.2)
    lifegame = Lifegame.new(size_x.to_i, size_y.to_i)

    # グライダー
    #lifegame[2,7].be!; lifegame[2,8].be!; lifegame[2,9].be!; lifegame[1,7].be!; lifegame[0,8].be!

    # 直線
    #lifegame[4,3].be!; lifegame[4,4].be!; lifegame[4,5].be!; lifegame[4,6].be!; lifegame[4,7].be!;

    lifegame.sow!(frequency.to_f)
    lifegame.start
  rescue Interrupt
    puts 'good bye world!'
  end
end
