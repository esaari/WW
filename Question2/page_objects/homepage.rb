class Homepage

  require 'selenium-webdriver'

  def initialize()
    @driver = Selenium::WebDriver.for :chrome
  end

  PAGE_URI = "https://www.weightwatchers.com/us/"

#*********** page actions ***********#

  def go_to_homepage
    @driver.navigate.to(PAGE_URI)
  end

  def click_find_a_studio
    find_a_studio_link = @driver.find_element(css: '.menu-link-find-a-studio .find-a-meeting')
    find_a_studio_link.click
  end

  def get_driver
    @driver
  end

end