require '../fixtures/days_to_index.rb'

include DAYS

#*********** Miscellaneous or commonly repeated functions go here ***********#

def check_system_ruby_version
#Check Ruby system version and install webdriver if >= 2.0
  ruby_version = `ruby -v`
  if ruby_version.split(' ')[1][0].to_i != 2
    puts "Ruby 2.0 or greater is required for this script/test to run. Please download from your O/S package repository."
    exit 1
  end
end

def webdriver_and_chromedriver_installed
  selenium_present = `gem list | grep 'selenium-webdriver'`
  chromedriver_present = `gem list | grep 'chromedriver'`
  if selenium_present.empty?
    install_webdriver
  end

  if chromedriver_present.empty?
    install_chromedriver
  end
end

def install_webdriver
  puts 'Please enter sudo password if prompted...'
  command_output = `sudo gem install selenium-webdriver`
  puts "Installing Selenium...\n\n #{command_output}"
end

def install_chromedriver
  puts 'Please enter sudo password if prompted...'
  command_output = `sudo gem install chromedriver-helper -v 1.0.0`
  puts "Installing Chromedriver...\n\n #{command_output}"
end

def collect_input
  puts "Please enter an abbreviated day of the week (Sun/Mon/Tue/Wed/Thur/Fri/Sat) to see how many meetings a coach has that day:"
  day = STDIN.gets.chomp.capitalize
  DAYS_HASH[day]
end

def page_title(driver)
  driver.title
end
