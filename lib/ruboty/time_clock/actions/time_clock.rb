module Ruboty
  module Timeclock
    module Actions
      class Timeclock < Ruboty::Actions::Base
        def call
          message.reply('dummy')
        end
      end
    end
  end
end
