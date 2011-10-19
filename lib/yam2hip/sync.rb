module Yam2Hip
  class Sync
    def self.since(time)
      messages = Yammer.since(time)
      puts messages.collect(&:to_s).join("\n\n")
    end
    
    def self.cron
      puts "Running cron"
    end
  end
end