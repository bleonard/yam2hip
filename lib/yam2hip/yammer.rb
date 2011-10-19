require 'httparty'

module Yam2Hip
  class Yammer
    class Message
      def initialize(hash)
        @hash = hash
      end
      
      def content
        @hash["body"]["rich"]
      end
      
      def plain
        @hash["body"]["plain"]
      end
      
      def key
        [url.split('/').last].flatten.first.to_s
      end
      
      def time
        Time.parse(@hash["created_at"])
      end
      
      def from
        Yammer.username(@hash["sender_id"])
      end
      
      def url
        @hash["web_url"]
      end
      
      def to_s
        "#{content} &nbsp; <a href='#{url}'>Thread...</a>"
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
      out.reverse
    end
    
    def self.username(user_id)
      response = get("/users/#{user_id}.json?access_token=#{Config.yammer_token}")
      response["full_name"] || response["name"]
    end
  end
end