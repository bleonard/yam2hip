module Yam2Hip
  def self.sync
    yam = diff(Yammer.messages, Hipchat.messages)
    Hipchat.send_all(yam)
  end
  
  def self.diff(yam, hip)
    # those that are in yam not in hip
    hash = {}
    
    puts "YAMMER...."
    yam.each do |msg|
      puts "   #{msg.key}: #{msg.plain}"
      hash[msg.key] = true
    end
    
    puts "HIPCHAT....."
    hip.each do |msg|
      puts "   #{msg.key}: #{msg.plain}"
      hash[msg.key] = true
    end
    
    out = yam.reject{ |msg| hash[msg.key] }
    
    puts "POSTING...."
    out.each do |msg|
      puts "   #{msg.key}: #{msg.plain}"
      hash[msg.key] = true
    end
    
    out
  end
end