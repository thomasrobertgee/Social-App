require 'date'
require 'csv'

class Message

  attr_accessor :username, :content, :time

  def initialize(message)
    @username = message['username']
    @content = message['content']
    @time = message['time']
  end

  def save
    new_message = [@username, @content, @time]
    CSV.open("messages.csv", "a+") do |csv|
      csv << new_message
    end
  end

end
