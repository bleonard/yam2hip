Dir["lib/**/*.rb"].each { |f| require f }

Yam2Hip::Sync.since(Time.now - 5*60*60)
