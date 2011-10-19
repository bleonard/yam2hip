require 'clockwork'
include Clockwork

Dir["#{File.dirname(__FILE__)}/lib/**/*.rb"].each { |f| require f }

handler do |job|
  puts "\n\n\ncalling sync..."
  Yam2Hip.sync
end

every(60.seconds, 'yam2hip')
