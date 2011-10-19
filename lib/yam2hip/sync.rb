module Yam2Hip
  def self.sync
    yam = Yammer.messages
    puts yam.collect(&:to_s).join("\n\n")
    
    puts "---------------"
    
    hip = Hipchat.messages
    puts hip.collect(&:to_s).join("\n\n")
  end
end