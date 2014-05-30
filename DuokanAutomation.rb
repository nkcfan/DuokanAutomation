#!/usr/bin/env ruby
# encoding: utf-8
require "rubygems"
require "bundler/setup"
require "capybara"
require "capybara/dsl"
require "capybara-webkit"
Capybara.run_server = false
Capybara.current_driver = :selenium
Capybara.javascript_driver = :chrome
Capybara.register_driver :selenium do |app|
  Capybara::Selenium::Driver.new(app, :browser => :chrome)
end

module WebAutomation
  class DuokanAutomation
    include Capybara::DSL
  
    def WaitFor(waitXPath)
      begin
        find(:xpath, waitXPath).set(true)
        return true
      rescue
        return false
      end
    end
    
    # Switch to latest browser window/tab
    def SwitchTab
      page.driver.browser.switch_to.window (page.driver.browser.window_handles.last)
    end
  
    def Login(url, username, password)
      visit(url)
      within_frame 'miniLoginFrame' do
        fill_in "miniLogin_username", :with => username
        fill_in "miniLogin_pwd", :with => password
        click_button "message_LOGIN_IMMEDIATELY"
      end
    end
    
    def DuokanMain(username, password)
      url = 'https://account.xiaomi.com/pass/serviceLogin?callback=http%3A%2F%2Flogin.dushu.xiaomi.com%2Fdk_id%2Fapi%2Fcheckin%3Ffollowup%3Dhttp%253A%252F%252Fwww.duokan.com%253Fapp_id%253Dweb%26sign%3DNGNmYWI3MjU0OTQwNjI1OTkwMDgzZDZlYWFkZmE4MTc%3D&sid=dushu';
      Login(url, username, password)

      expSaleImage = "//li/a[img[@alt='限时免费']]"
      return "login failed" unless WaitFor(expSaleImage) 
      find(:xpath, expSaleImage).click
      SwitchTab()

      expPurchaseButton = "//a[@class='u-btn j-get']"
      return "ignore" unless WaitFor(expPurchaseButton)
      find(:xpath, expPurchaseButton).click
      
      return "purchased"
    end
  end
end

if ($0 == __FILE__)
  usage = "USAGE:\n#{$0} username password"
  if (ARGV.length != 2)
    puts usage
    exit
  end

  username = ARGV[0]
  password = ARGV[1]

  auto = WebAutomation::DuokanAutomation.new
  msg = auto.DuokanMain(username, password)
  puts "[#{Time.now}] #{msg}";
end
