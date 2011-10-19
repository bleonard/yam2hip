require 'httparty'

module Yam2Hip
  class Hipchat
    class Message
      def initialize(hash)
        @hash = hash
      end
      
      def content
        plain
      end
      
      def plain
        @hash["message"]
      end
      
      def key
        val = plain.scan(/\/messages\/(\d+)/)
        if val.empty?
          plain.to_s
        else
          val.flatten.last.to_s
        end
      end
      
      def from
        @hash["from"]["full_name"]
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
    
    def self.send_all(yam)
      yam.each do |msg|
        send(msg.to_s, msg.from)
      end
    end
    
    def self.send(content, from)
      from ||= ""
      pieces = from.split(" ")
      from = "#{pieces[0]} #{pieces[1][0,1]}." if pieces.size > 1
      
      post("/rooms/message?format=json&auth_token=#{Config.hipchat_token}", 
              :query => { :room_id => Config.hipchat_room_id,
                          :from => from[0,11] || "Yammer",
                          :message => content})
    end
  end
end