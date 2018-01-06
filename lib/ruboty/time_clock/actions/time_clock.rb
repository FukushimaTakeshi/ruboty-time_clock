module Ruboty
  module TimeClock
    module Actions
      class TimeClock < Ruboty::Actions::Base
        def call
          message.reply('dummy')
        end
      end
    end
  end
end
