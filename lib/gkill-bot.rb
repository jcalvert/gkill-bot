require 'pry'
require 'yaml'
require 'active_record'
require 'sqlite3'
require 'discordrb'

#TODO Organize this crap
module Gkill
  class Bot

    def self.next_date
	"some imaginary time later"
    end
    def self.setup
    	Dir.glob('./lib/*').each do |folder|
		     Dir.glob(folder +"/*.rb").each do |file|
		     require file
		     end
		     end

		# tells AR what db file to use
	ActiveRecord::Base.establish_connection(
		:adapter => 'sqlite3',
		:database => 'gkill.db'
	)
    end

    def self.run
      setup
      conf = YAML::load_file('config.yml')
      bot = Discordrb::Bot.new token: conf['token'], client_id: conf['client_id']

      @rollcall = [] #obv replace with orm
      @whois = {}

      command_bot = Discordrb::Commands::CommandBot.new token: conf['token'], client_id: conf['client_id'], prefix: "!"

      command_bot.command(:whoiam) do |event, *args|
	@whois[event.user.username] = args.join(" ")
      end

      command_bot.command(:whois) do |event, *args|
	username = event.user.username
	if @whois[args.join(' ')]
	  @whois[args.join(' ')]
	else
	  "Sorry, I don't know who #{args.join(' ')} is or that person has not told me who they are"
	end
      end

      command_bot.command(:checkin, description: '', usage: '') do |event|
	username = event.user.username
	@rollcall << username
	"You are checked in for the next match on #{next_date}"
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

      bot.message(content: 'Who is OddBall39?') do |event|
        event.respond 'Tor up from the floor up! https://i.pinimg.com/736x/90/9b/55/909b5599394a390796e07c0fab54092f--kellys-heroes-donald-sutherland.jpg'
      end


      Thread.new { bot.run }
      Thread.new { command_bot.run }
    end

  end
end

Gkill::Bot.run
