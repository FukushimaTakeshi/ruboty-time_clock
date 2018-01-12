require 'capybara'
require 'capybara/dsl'
require 'capybara/poltergeist'
require 'holiday_jp'

Capybara.configure do |config|
  config.run_server = false
  config.current_driver = :poltergeist
  config.javascript_driver = :poltergeist
  config.app_host = 'https://chronus-ext.tis.co.jp/Lysithea/JSP_Files/authentication/WC010_1.jsp'
  config.default_wait_time = 5
end

Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app, { timeout: 120, js_errors: false })
end

module Ruboty
  module TimeClock
    module Actions
      class TimeClock < Ruboty::Actions::Base
        include Capybara::DSL

        attr_reader :message, :id, :password, :start_time, :end_time

        def initialize(message:, id:, password:, start_time:, end_time:)
          @message = message
          @id = id
          @password = password
          @start_time = start_time
          @end_time = end_time
        end

        def call
          login
          select_date
          register_attendance
          if success?
            message.reply('登録しました')
          else
            message.reply('失敗しました >_<;')
          end
          logout
        end

        private

        def login
          page.driver.headers = { 'User-Agent': 'Mac Safari' }
          visit('')
          select('100：TIS株式会社', from: 'CompanyID')
          find(:xpath, "//input[@class='InputTxtL'][@name='PersonCode']").set(id)
          find(:xpath, "//input[@class='InputTxtL'][@name='Password']").set(password)
          find(:xpath, "//*/a").click
        end

        def select_date
          page.accept_alert
          # frame name="MENU" の操作
          page.driver.within_frame('MENU') do
            # カレンダーから前営業日をクリック
            find(:xpath, "//*[@id='side00']//tbody//table[2]").all('a').each do |link|
              link.click if link.text == last_business_day
            end
          end
        end

        def last_business_day(today = Date.today - 1 )
          if today.wday == 6 # Sat.
            today -= 1
          elsif today.wday == 0 # Sun.
            today -= 2
          elsif HolidayJp.holiday?(today) # public holiday
            today -= 1
          else
            return today.day.to_s
          end
          last_business_day(today)
        end

        def register_attendance
          page.driver.within_frame('OPERATION') do
            if start_time && end_time
              find(:xpath, "//*[@class='InputTxtR'][@name='StartTime']").set(start_time)
              find(:xpath, "//*[@class='InputTxtR'][@name='EndTime']").set(end_time)
            end
            find(:xpath, "//a[2]/img").click
          end
        end

        def success?
          page.driver.within_frame('OPERATION') do
            find(:xpath, "//*[@class='BdCel2'][@align='CENTER']").has_text?('△')
          end
        end

        def logout
          page.driver.within_frame('MENU') do
            find(:xpath, "//*/table[10]//td[2]//img").click
          end
        end
      end
    end
  end
end
