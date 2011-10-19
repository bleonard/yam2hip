require 'clockwork'
include Clockwork

Dir["#{File.dirname(__FILE__)}/lib/**/*.rb"].each { |f| require f }

handler do |job|
  puts "\n\n\ncalling sync..."
  Yam2Hip.sync
end

every(90.seconds, 'yam2hip')
