module Yam2Hip
  def self.sync
    yam = diff(Yammer.messages, Hipchat.messages)
    Hipchat.send_all(yam)
  end
  
  def self.diff(yam, hip)
    # those that are in yam not in hip
    hash = {}
    hip.each do |msg|
      hash[msg.key] = true
    end
    yam.reject{ |msg| hash[msg.key] }
  end
end