require 'pry'
require 'yaml'
require 'discordrb'

#TODO Organize this crap
module Gkill
  class Bot

    def self.run
      conf = YAML::load_file('config.yml')
      bot = Discordrb::Bot.new token: conf['token'], client_id: conf['client_id']

      @rollcall = [] #obv replace with orm

      command_bot = Discordrb::Commands::CommandBot.new token: conf['token'], client_id: conf['client_id'], prefix: "!"

      command_bot.command(:checkin, description: '', usage: '') do |event|
        binding.pry
        "You are in my soul!"
      end

      command_bot.command(:rollcall, description: '', usage: '') do |event|
        "Current checked in players: #{@rollcall.join(', ')}"
      end

      bot.message(content: 'Ping!') do |event|
        event.respond 'Pong!'
      end

      bot.message(content: 'What is best in life?') do |event|
        event.respond 'To crush your enemies. See them driven before you. And to hear the lamentations of their women.'
      end

      bot.message(content: 'Who is Athemeus?') do |event|
        event.respond 'My lord and master.'
      end

      bot.message(content: 'Who is OddBall 39?') do |event|
        event.respond 'Tor up from the floor up! https://i.pinimg.com/736x/90/9b/55/909b5599394a390796e07c0fab54092f--kellys-heroes-donald-sutherland.jpg'
      end

      Thread.new { command_bot.run }

      bot.run
    end

  end
end

Gkill::Bot.run
