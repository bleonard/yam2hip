module Yam2Hip
  class Sync
    def self.since(date)
      puts "Running sync"
    end
    
    def self.cron
      puts "Running cron"
    end
  end
end