require 'httparty'

module Yam2Hip
  class Yammer
    class Message
      def initialize(hash)
        @hash = hash
      end
      
      def content
        @hash["body"]["plain"]
      end
      
      def time
        Time.parse(@hash["created_at"])
      end
      
      def url
        @hash["web_url"]
      end
      
      def to_s
        "#{content}\n#{url}"
      end
      
      def public?
        @hash["privacy"] == "public" && @hash["direct_message"] == false
      end
    end
    
    include ::HTTParty
    base_uri 'http://www.yammer.com/api/v1'

    def self.fetch
      response = get("/messages.json?access_token=#{Config.yammer_token}")
      response.each do |item|
        return item.last if item.first == "messages"
      end
      return []
    end
    
    def self.messages
      out = []
      fetch.each do |hash|
        msg = Message.new(hash)
        out << msg if msg.public?
      end
      out
    end
  end
end