module Yam2Hip
  def self.sync
    puts "\n---Yammer-------------"
    yam = Yammer.messages
    puts yam.collect(&:to_s).join("\n\n")
    
    puts "\n---Hipchat------------"
    
    hip = Hipchat.messages
    puts hip.collect(&:to_s).join("\n\n")
    
    puts "\n---Diff-----------------"
    
    messages = diff(yam,hip)
    puts messages.collect(&:to_s).join("\n\n")
  end
  
  def self.diff(yam, hip)
    # those that are in yam not in hip
    hash = {}
    hip.each do |msg|
      hash[msg.to_s] = true
    end
    yam.reject{ |msg| hash[msg.to_s] }
  end
end