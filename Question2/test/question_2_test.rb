#!/usr/bin/ruby

require '../support/helper.rb'
require '../page_objects/homepage.rb'
require '../page_objects/find_a_meeting.rb'
require 'selenium-webdriver'
require 'test/unit'
extend Test::Unit::Assertions

include DAYS

#Setup for test execution
check_system_ruby_version
webdriver_and_chromedriver_installed
####################################


@page = Homepage.new
driver = @page.get_driver
@page.go_to_homepage

assert_equal("WW (Weight Watchers): Weight Loss & Wellness Help", page_title(driver), failure_message = "Page title not equal to expected, make sure page loaded." )

@page.click_find_a_studio
@page = FindAMeeting.new(driver)
@page.page_loaded

assert(page_title(driver).include? "Find a Studio & Meeting Near You | WW USA")

@page.find_meeetings_by_zip("10011")
@page.print_first_result_title_and_distance

index = collect_input
@page.print_schedule(index)

driver.quit
