class NewsTracker::CLI

  def initialize

  end

  def greet_user
    puts "------------------------------------------------------------------\n  Welcome to News Tracker - Ruby/Rails/Javascript and Node News!\n------------------------------------------------------------------"
  end

  def list_options
    puts "  Select an option\n  '1' for Ruby news\n  '2' for Javascript news\n  '3' for NodeJS news\n  Type 'exit' to quit\n\n"
  end

  def call
    # TODO
    self.greet_user
    self.menu
  end

  def menu
    # TODO
    self.list_options
    # capture & process user input
  end

end