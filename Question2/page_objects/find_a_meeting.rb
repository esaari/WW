class FindAMeeting

  def initialize(driver)
    @driver = driver
  end

PAGE_URI = "https://www.weightwatchers.com/us/find-a-meeting/"

#*********** page actions ***********#

  def page_loaded
    wait = Selenium::WebDriver::Wait.new(timeout: 10) # seconds
    wait.until { @driver.find_element(css: '#meetingSearch') }
  end

  def find_meeetings_by_zip(zip_code)
    zip_code_text_field = @driver.find_element(css: '#meetingSearch')
    submit_button = @driver.find_element(css: '.input-group-btn button')
    zip_code_text_field.send_keys(zip_code.to_s)
    submit_button.click
  end

  def print_first_result_title_and_distance
    titles = @driver.find_elements(css: '.location__name [ng-if="!linkName"]')
    distances = @driver.find_elements(css: '.location__distance[ng-if="showDistance"]')
    puts "Name: #{titles[0].text}:    Distance: #{distances[0].text}\n\n"
    titles[0].click
  end

  def print_schedule(index)
    leaders = []
    leader_count = {}
    leaders_by_day = @driver.find_elements(css: ".schedule-detailed-day:nth-child(#{index}) .schedule-detailed-day-meetings-item-leader")

    leaders_by_day.each do |leader_name|
      leaders << leader_name.text
    end

    leaders.uniq.each do |leader|
      leader_count[leader] = leaders.count(leader)
    end

    leader_count.each do |leader, number_of_meetings|
      puts "Name: #{leader}    Total: #{number_of_meetings} time(s)\n\n"
    end
  end

end