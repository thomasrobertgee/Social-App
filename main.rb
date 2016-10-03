require 'date'
require './messages'
require './user'

  def start
    puts "============================================"
    puts "Welcome."
    sleep 0.5
    puts "Are you a user or administrator?"
    sleep 0.5
    puts "1. User"
    puts "2. Administrator"

    print "> "
    role = $stdin.gets.chomp

    if role == "1"
      start_menu
    elsif role == "2"
      admin_password_confirm
    else
      puts "Choice not valid. Please try again."
      start
    end
  end

  def start_menu
    puts "============================================"
    puts "1. Login"
    puts "2. Create an account"
    print "> "
    user_login_choice = $stdin.gets.chomp

    if user_login_choice == "1"
      user_login
    elsif user_login_choice == "2"
      new_user_menu
    else
      puts "Choice not valid. Please try again."
      start
    end
  end

  def admin_password_confirm
    system 'stty -echo'
    print "Enter passord for entry: "
    admin_password = $stdin.gets.chomp
    system 'stty echo'
    if admin_password == "tom"
      admin_main_menu
    else
      puts "Password incorrect."
      admin_password_confirm
    end
  end

  def user_login
    login_start
    verified(gets.chomp)
  end

  def verified(input)
    user_row = authentication(input)
    if user_row
      system 'stty -echo'
      puts 'Please enter your password:'
      print "> "
      password = gets.chomp
      system 'stty echo'
      if user_row['password'] == password
        user_mainmenu(input)
      else
        puts "Incorrect password."
        sleep 1
        user_login
      end
    else
      failed
    end
  end

  def authentication(username)
    CSV.open('users.csv', headers: true).find { |row| row['username'] == username }
  end

  def failed
    puts "Username not recognised. Please try again."
    sleep(1)
    user_login
  end

  def login_start
    puts "Enter username:"
    print "> "
  end

  def user_mainmenu(input)
    puts " "
    puts "~~~~~~~~~~~~ USER MAIN MENU ~~~~~~~~~~~~~"
    puts "Welcome. What would you like to do today?"
    puts "1. View recent public messages"
    puts "2. View my details"
    puts "3. My messages menu"
    puts "4. Delete my account"
    puts " "
    puts "[E]xit app"

    print "> "
    user_mainmenu_choice = $stdin.gets.chomp

    if user_mainmenu_choice == "1"
      puts "============================================"
      puts "Messages feature not yet available! Please come back later."
      sleep 1
      user_mainmenu(input)
    elsif user_mainmenu_choice == "2"
      my_details(input)
    elsif user_mainmenu_choice == "3"
      messages_menu(input)
    elsif user_mainmenu_choice == "4"
      user_delete_account(input)
    elsif user_mainmenu_choice == "e" || user_mainmenu_choice == "E"
      puts "============================================"
      puts "We hope to see you again."
      sleep 1
      exit
    else
      puts "============================================"
      puts "Choice not valid. Please try again."
      sleep 1
      user_mainmenu(input)
    end
  end

  def messages_menu(input)
    puts " "
    puts "============================================"
    puts "What do you want to do now?"
    puts "1. Post a new message"
    puts "2. View my posted messages"
    puts "3. Go back to main menu"
    puts "4. Exit app"

    print "> "
    messages_menu_choice = $stdin.gets.chomp

    if messages_menu_choice == "1"
      post_message_menu(input)
    elsif messages_menu_choice == "2"
      my_posted_messages(input)
    elsif messages_menu_choice == "3"
      user_mainmenu(input)
    elsif messages_menu_choice == "4"
      puts "============================================"
      puts "We hope to see you again."
      sleep 2
      exit
    else
      puts "============================================"
      puts "Choice not valid. Please try again."
      sleep 1
      messages_menu(input)
    end
  end

  def post_message_menu(input)
    new_message_menu(input)
    puts " "
    puts "==================================================="
    puts "Sweet! Message has been posted."
    puts "What would you like to do now?"
    puts "1. Post another message"
    puts "2. Back to main menu"
    print "> "
    post_message_menu_choice = gets.chomp
    if post_message_menu_choice == "1"
      new_message_menu(input)
    elsif post_message_menu_choice == "2"
      user_mainmenu(input)
    else
      puts "Input not recognized. Please try again."
      sleep 1
      post_message_menu(input)
    end
  end

  def new_message_menu(input)
    puts "==================================================="
    puts "What would you like to post?"
    print "> "
    content = $stdin.gets.chomp
    username = username

    new_message = {
    'username' => username,
    'content' => content,
    'date' => DateTime.now

    }
    @message = Message.new(new_message)
    @message.save
  end

  def my_posted_messages(input)
    CSV.foreach("./messages.csv", headers: true) do |row|
      if row["username"] == (input)

      username = row['username']
      content = row['content']
      time = row['time']

      puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"

      puts "#{username}"
      puts "#{content}"
      puts "#{time}"

    end
  end
  end


  def my_details(input)
    user_details(input)
    puts "============================="
    puts "What do you want to do now?"
    puts "1. Edit my details"
    puts "2. Delete my account"
    puts "3. Go back to main menu"
    puts "4. Exit app"

    print "> "
    my_details_choice = $stdin.gets.chomp

    if my_details_choice == "1"
      # puts "============================================"
      # puts "Feature not yet available! Please come back later."
      # sleep 1
      # my_details(input)
      edit_details(input)
    elsif my_details_choice == "2"
      puts "============================================"
      puts "Feature not yet available! Please come back later."
      sleep 1
      my_details(input)
    elsif my_details_choice == "3"
      user_mainmenu(input)
    elsif my_details_choice == "4"
      puts "============================================"
      puts "We hope to see you again."
      sleep 2
      exit
    else
      puts "Choice not valid. Please try again."
      sleep 1
      my_details_choice
    end
  end

  def user_details(username)
    CSV.foreach("./users.csv", headers: true) do |row|
      if row["username"] == username
      first_name = row['first_name']
      age = row['age']
      location = row['location']
      gender = row['gender']
      phone_number = row['phone_number']
      username = row['username']
      email = row['email']
      password = row['password']

      puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"

      puts "First name: #{first_name}"
      puts "Age: #{age}"
      puts "Location: #{location}"
      puts "Gender: #{gender}"
      puts "Phone number: #{phone_number}"
      puts "Username: #{username}"
      puts "Email: #{email}"
      puts "Password: ********"
    end
  end
  end


  def edit_details(input)
    puts "============================================"
    puts "Which details would you like to edit?"
    puts "1. Username"
    puts "2. First name"
    puts "3. Age"
    puts "4. Gender"
    puts "5. Location"
    puts "6. Phone number"
    puts "7. Email address"
    puts "8. Nevermind, take me back to main menu"

    print "> "
    edit_details_choice = $stdin.gets.chomp

    if edit_details_choice == "1"
      # puts "You cannot change your username, this was disclosed during account creation."
      # puts "Please choose another option."
      puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
      puts "Function not yet available! Please try again later."
      sleep 1
      edit_details(input)
    elsif edit_details_choice == "2"
      # puts "Really? I hope it's something cooler than what you put last time."
      # add functionality to send a request to admin to change this detail.
      puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
      puts "Function not yet available! Please try again later."
      sleep 1
      edit_details(input)
    elsif edit_details_choice == "3"
      # puts "Sure, go ahead. What is your new 'age'?"
      # add functionality to send a request to admin to change this detail.
      puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
      puts "Function not yet available! Please try again later."
      sleep 1
      edit_details(input)
    elsif edit_details_choice == "4"
      # puts "Sex change? What is it now?"
      # add functionality to send a request to admin to change this detail.
      puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
      puts "Function not yet available! Please try again later."
      sleep 1
      edit_details(input)
    elsif edit_details_choice == "5"
      # puts "How was the move? Not too stressful I hope. Where are you now?"
      # add functionality to send a request to admin to change this detail.
      puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
      puts "Function not yet available! Please try again later."
      sleep 1
      edit_details(input)
    elsif edit_details_choice == "6"
      # puts "Hey hey hey, new digits. Throw them at me."
      # add functionality to send a request to admin to change this detail.
      puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
      puts "Function not yet available! Please try again later."
      sleep 1
      edit_details(input)
    elsif edit_details_choice == "7"
      # puts "Why the change? Actually nevermind I don't care. Just enter it."
      # add functionality to send a request to admin to change this detail.
      puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
      puts "Function not yet available! Please try again later."
      sleep 1
      edit_details(input)
    elsif edit_details_choice == "8"
      user_mainmenu(input)
    else
      puts "Choice not recognized. Try again."
      edit_details(input)
    end
  end

  def user_delete_account(input)
    puts "============================================"
    puts "Are you sure you want to do this?"
    sleep 1
    puts "[y]es or [n]o"

    print "> "
    user_delete_account_choice = $stdin.gets.chomp

    if user_delete_account_choice == 'y'
      puts "============================================"
      #send a request to the admin
      # puts "Account deleted."
      # sleep 1
      # print "."
      # sleep 0.5
      # print "."
      # sleep 0.5
      # print "."
      # sleep 0.5
      # exit
      puts "Function not yet available! Please try again later"
      sleep 1
      user_mainmenu(input)
    elsif user_delete_account_choice == 'n'
      puts "Smart choice."
      sleep 1
      user_mainmenu(input)
    else
      puts "Choice not valid. Please try again."
      sleep 1
      user_delete_account(input)
    end
  end


  def new_user_menu
    puts "==================================================="
    puts "Thank you for choosing to create an account with us!"
    sleep 0.5

    puts "What is your first name?"
    print "> "
    first_name = $stdin.gets.chomp

    puts "And your age?"
    print "> "
    age = $stdin.gets.chomp

    puts "Where do you live?"
    print "> "
    location = $stdin.gets.chomp

    def gender_choice
      puts "Are you [m]ale or [f]emale?"
      print "> "
      gender = $stdin.gets.chomp

      if gender == "m"
        return "Male"
      elsif gender == 'f'
        return "Female"
      else
        puts "Input not recognized. Please select 'm' or 'f'."
        gender_choice
      end
    end
    gender = gender_choice

    puts "Add your phone number:"
    print "> "
    phone_number = $stdin.gets.chomp

    puts "And your email address:"
    print "> "
    email = $stdin.gets.chomp

    puts "Please choose your username."
    puts "This is what you will use to login with."
    print "> "
    username = $stdin.gets.chomp

    puts "Hmm"
    sleep 0.5
    puts "."
    sleep 0.5
    puts "..."
    sleep 0.5
    puts "."
    sleep 0.5
    print "."
    sleep 0.5
    print "."
    sleep 0.5
    print "."
    sleep 0.5
    print "."
    sleep 0.5
    puts "."
    sleep 0.5
    puts "Yeah nice, I like that one."
    sleep 1

    password = password_create

    new_user = {
    'first_name' => first_name,
    'age' => age,
    'location' => location,
    'gender' => gender,
    'phone_number' => phone_number,
    'email' => email,
    'username' => username,
    'password' => password
    }
    @user = User.new(new_user)
    @user.save
  end

  def password_create
    system 'stty -echo'
    puts "Enter your password:"
    print "> "
    password = $stdin.gets.chomp

    puts "Please confirm your password"
    print "> "
    confirm_password = $stdin.gets.chomp
    system 'stty echo'

    if password == confirm_password
      puts "Account created! Congratulations."
      puts "Please restart the app to login with your new account."
      password
    else
      puts "Password was not the same."
      sleep 1
      password_create
    end
  end

 ##############################################################################
 ##############################################################################
 ##############################################################################
 ##############################################################################
 ##############################################################################
 ##############################################################################

  def admin_main_menu
    puts
    puts "Welcome back my benevolence. What do you wish to achieve today?"
    puts "~~~~~~~~~~ADMIN MAIN MENU~~~~~~~~~~"
    puts "1. View users"
    puts "2. Delete a user"
    puts "3. View posts"
    puts "4. Exit app"

    print "> "
    main_menu_choice = $stdin.gets.chomp

    if main_menu_choice == "1"
      view_users_menu
    elsif main_menu_choice == "2"
      delete_user_menu
    elsif main_menu_choice == "3"
      view_posts_menu
    elsif main_menu_choice == "4"
      puts "Smell ya later!"
      sleep 1
      exit
    else
      puts "Choice not valid. Please try again."
      sleep 1
    end
  end

  def view_users_menu
    puts "================================="
    all_user_details
    puts " "
    puts "What do you want to do now?\n"
    puts "1. View user messages"
    puts "2. Delete user"
    puts "3. Go back to main menu"
    # add display list of users and other options here

    print "> "
    view_users_menu_choice = $stdin.gets.chomp

    if view_users_menu_choice == "1"
      # display all messages from the user
      puts "Feature not yet available! Please come back later."
      sleep 1
      view_users_menu
    elsif view_users_menu_choice == "2"
      # delete user
      puts "Feature not yet available! Please come back later."
      sleep 1
      view_users_menu
    elsif view_users_menu_choice == "3"
      admin_main_menu
    else
      puts "Choice not valid. Please try again."
      sleep 1
      view_users_menu
    end
  end

  def all_user_details
    CSV.foreach("./users.csv", headers: true) do |row|
      first_name = row['first_name']
      age = row['age']
      location = row['location']
      gender = row['gender']
      phone_number = row['phone_number']
      username = row['username']
      email = row['email']
      password = row['password']

      puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"

      puts "First name: #{first_name}"
      puts "Age: #{age}"
      puts "Location: #{location}"
      puts "Gender: #{gender}"
      puts "Phone number: #{phone_number}"
      puts "Username: #{username}"
      puts "Email: #{email}"
      puts "Password: ********"

      sleep 0.5
    end
  end

  # def add_new_user_menu
  #   add_new_user
  # end
  #
  # def add_new_user
  #   puts " "
  #   CSV.foreach("./users.csv", headers: true) do |row|
  #     first_name = row['first_name']
  #     age = row['age']
  #     location = row['location']
  #     gender = row['gender']
  #     phone_number = row['phone_number']
  #     username = row['username']
  #     email = row['email']
  #     password = row['password']
  #
  #     puts "First name: #{first_name}"
  #     puts "Age: #{age}"
  #     puts "Location: #{location}"
  #     puts "Gender: #{gender}"
  #     puts "Phone number: #{phone_number}"
  #     puts "Username: #{username}"
  #     puts "Email: #{email}"
  #     puts "Password: ********"
  #
  #     puts " "
  #     puts "[a]pprove / [r]eject / [e]xit to main menu"
  #     print "> "
  #     new_user_choice = $stdin.gets.chomp
  #
  #     if new_user_choice == "a"
  #       # move new user from pending_users.csv to users.csv
  #       approve_user
  #     elsif new_user_choice == "r"
  #       # delete new user from pending_users.csv
  #       delete_user
  #     elsif new_user_choice == "e"
  #       admin_main_menu
  #     else
  #       puts "Choice not valid. Please try again."
  #       sleep 1
  #       add_new_user_menu
  #     end
  #   end
  # end
  #
  # def approve_user
  #   # function not yet available
  # end
  #

  def delete_user_menu
    puts "============================================"
    delete_users_active_list
    puts " "
    puts "Please type in the name of the user you wish to eradicate: "
    print "> "
    eradicate(gets.chomp)
  end

  def eradicate(delete_input)
    delete_row = delete_authentication(delete_input)
    if delete_row
      puts "Are you sure you want to delete #{delete_input} from the database?"
      puts "[y]es or [n]o"
      print "> "
      delete_answer = $stdin.gets.chomp
      if delete_answer == "y"
        delete_user(delete_input)
        after_deletion_menu
      elsif delete_answer == "n"
        puts "Close call! Taking you back to main menu."
        sleep 2
        admin_main_menu
      elsif users.empty? == true
        puts "There are no users in the database. If you feel like deleting someone go launch a nuke or something."
        admin_main_menu
      else
        puts "Input not recognised. Please try again."
        eradicate(delete_input)
      end
    else
      puts "User not recognized. Please try again."
      sleep 1
      delete_user_menu
    end
  end

  def delete_user(delete_input)
    table = CSV.table("./users.csv")

    table.delete_if do |row|
      row[:username] == 'true'
    end

    File.open("./users.csv", 'w') do |f|
      f.write(table.to_csv)
    end

    after_deletion_menu
  end

  def delete_users_active_list
    CSV.foreach("./users.csv", headers: true) do |row|
      username = row['username']
      puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
      puts "Username: #{username}"
    end
  end

  def delete_authentication(username)
    CSV.open('users.csv', headers: true).find { |row| row['username'] == username }
  end

  def after_deletion_menu
    puts " "
    puts "User deleted! What would you like to do now?"
    puts "1. Delete another user"
    puts "2. Back to main menu"
    print "> "
    after_deletion_choice = gets.chomp
    if after_deletion_choice == "1"
      delete_user_menu
    elsif after_deletion_choice == "2"
      admin_main_menu
    else
      puts "Input not recognized. Please try again."
      after_deletion_menu
    end
  end

  def view_posts_menu
    # add view posts functionality here

    # puts "What would you like to do now oh wise one?"
    puts "============================================"
    puts "Function not yet available. Please try again later!"
    sleep 1
    admin_main_menu
  end

start
