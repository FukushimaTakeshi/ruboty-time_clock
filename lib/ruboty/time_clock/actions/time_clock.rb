module ruboty
  module Timeclock
    module actions
      class Timeclock < Ruboty::Actions::Base
        def call
          message.reply('dummy')
        end
      end
    end
  end
end
