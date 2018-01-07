require 'capybara'
require 'capybara/dsl'
require 'capybara/poltergeist'

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

        attr_reader :message, :id, :password

        def initialize(message:, id:, password:)
          @message = message
          @id = id
          @password = password
        end

        def call
          message.reply(login)
        end

        private

        def login
          page.driver.headers = { 'User-Agent': 'Mac Safari' }
          visit('')
          select('100：TIS株式会社', from: 'CompanyID')
          find(:xpath, "//input[@class='InputTxtL'][@name='PersonCode']").set(id)
          find(:xpath, "//input[@class='InputTxtL'][@name='Password']").set(password)
          find(:xpath, "//*/a").click
          p find(:xpath, "/html/body/form[3]/center[1]/table/tbody/tr/td/font").text
          find(:xpath, "/html/body/form[3]/center[1]/table/tbody/tr/td/font").text
        end

        def register_attendance
        end
      end
    end
  end
end
