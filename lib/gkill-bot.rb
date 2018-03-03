require 'yaml'
require 'discordrb'

module Gkill
  class Bot

    def self.run
      conf = YAML::load_file('config.yml')
      bot = Discordrb::Bot.new token: conf['token'], client_id: conf['client_id']
      bot.message(content: 'Ping!') do |event|
        event.respond 'Pong!'
      end

      bot.message(content: 'What is best in life?') do |event|
        event.respond 'To crush your enemies. See them driven before you. And to hear the lamentations of their women.'
      end

      bot.message(content: 'Who is Athemeus?') do |event|
        event.respond 'My lord and master.'
      end

      bot.run
    end

  end
end

Gkill::Bot.run
