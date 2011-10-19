Dir["lib/**/*.rb"].each { |f| require f }

Yam2Hip::Sync.since(Time.now - 48*60*60)
