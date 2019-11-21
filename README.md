# Lifegame

[![demo](./demo.gif)](./demo.gif)


demo: `git clone` and `bundle install` and `bundle exec ./bin/demo`

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'lifegame'
```
And then execute:

```
$ bundle install
```

Or install it yourself as:

```
$ gem install lifegame
```

## Usage

```ruby
# 100 x 100
game = Lifegame::Lifegame.new(100, 100)

# eg: grader
game[2,7].be!; game[2,8].be!; game[2,9].be!; game[1,7].be!; game[0,8].be!

# print
puts game

# next
game.next!
puts game

# autoplay
game.start

# random with alive frequency
game.sow!(0.2)
game.start
```

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
