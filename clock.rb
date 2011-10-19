require 'clockwork'
include Clockwork

Dir["lib/**/*.rb"].each { |f| require f }

handler do |job|
  Yam2Hip::Sync.cron
end

every(30.seconds, 'yam2hip')
