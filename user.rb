require 'csv'

class User

  attr_accessor :first_name, :age, :loction, :gender, :phone_number, :email, :username, :password

  def initialize(user)
    @first_name = user['first_name']
    @age = user['age']
    @location = user['location']
    @gender = user['gender']
    @phone_number = user['phone_number']
    @email = user['email']
    @username = user['username']
    @password = user['password']
  end

  def save
    user = [@first_name, @age, @location, @gender, @phone_number, @email, @username, @password]
    CSV.open("users.csv", "a+") do |csv|
      csv << user
    end
  end
end
