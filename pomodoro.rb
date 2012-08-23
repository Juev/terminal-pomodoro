#!/usr/bin/env ruby-local-exec
# encoding: UTF-8

require "bundler/setup"
require "colorize"
require "terminal-notifier"

WORK = 1#25 * 60 # 25 min in sec
REST = 1#5 * 60 # 5 min in sec
LONG = 1#15 * 60 # adding 15 min Rest in sec
REPEAT = 2#4 # count for long rest

def period(t, message, color)
  TerminalNotifier.notify(message, :title => 'Pomodoro', :group => 'Pomodoro')
  puts "#{message} #{t / 60} min.".colorize( color )
  sleep t # sec  
end

def exit?
  TerminalNotifier.notify('New workout?', :title => 'Pomodoro', :group => 'Pomodoro')
  puts "If you want to continue, press Return, or Ctrl+C to exit".colorize( :yellow )
  begin
    gets
  rescue Exception => e
    puts "\nThank you for using Pomodoro!\nGoodbye!".colorize( :red )
    exit
  end  
end

while true
  (0..REPEAT).each{ |count|
    period(WORK, "Work", :blue)
    count == REPEAT ? \
      period(LONG, "Long Rest", :red) : \
      period(REST, "Rest", :gray)
    # period(REST, "Rest", :gray) if count < REPEAT
    # period(LONG, "Long Rest", :red) if count == REPEAT
    exit?
  }
end
