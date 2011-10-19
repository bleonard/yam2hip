module Yam2Hip
  def self.sync
    messages = diff(Yammer.messages, Hipchat.messages)
    Hipchat.post(messages)
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