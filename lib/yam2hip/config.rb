module Yam2Hip
  class Config
    def self.yammer_token
      ENV['YAMMER_OAUTH']
    end
    
    def self.hipchat_token
      ENV['HIPCHAT_TOKEN']
    end
    
    def self.hipchat_room_id
      ENV['HIPCHAT_ROOM']
    end
    
  end
end