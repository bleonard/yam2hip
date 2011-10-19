module Yam2Hip
  def self.sync
    hip = Hipchat.messages
    yam = Yammer.messages
    post = diff(yam, hip)
    if hip.size == 0
      puts "No hipchat messages!"
    elsif yam.size == 0
      put "No Yammer messages"
    else
      Hipchat.send_all(post)
    end
  end
  
  def self.diff(yam, hip)
    # those that are in yam not in hip
    hash = {}
    
    puts "YAMMER...."
    yam.each do |msg|
      puts "   #{msg.key}: #{msg.plain}"
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
    end
    
    out
  end
end