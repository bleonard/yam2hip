require 'httparty'

module Yam2Hip
  class Hipchat
    class Message
      def initialize(hash)
        @hash = hash
      end
      
      def content
        @hash["message"]
      end
      
      def time
        Time.parse(@hash["date"])
      end

      def to_s
        "#{content}"
      end
    end
    
    include ::HTTParty
    base_uri 'https://api.hipchat.com/v1'

    def self.fetch
      response = get("/rooms/history?room_id=#{Config.hipchat_room_id}&date=recent&format=json&auth_token=#{Config.hipchat_token}")
      response["messages"] || []
    end
    
    def self.messages
      out = []
      fetch.each do |hash|
        out << Message.new(hash)
      end
      out
    end
  end
end