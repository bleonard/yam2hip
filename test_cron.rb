Dir["lib/**/*.rb"].each { |f| require f }

Yam2Hip::Sync.cron
