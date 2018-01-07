require "ruboty/time_clock/actions/time_clock"

module Ruboty
  module Handlers
    class TimeClock < Base
      on /time_clock (?<id>.*?) (?<password>.*?)\z/, name: 'time_clock', description: 'output time_clock result'

      def time_clock(message)
        Ruboty::TimeClock::Actions::TimeClock.new(time_clock_params(message)).call
      end

      private

      def time_clock_params(message)
        id, password = message.match_data[1..2]
        { message: message, id: id, password: password }
      end
    end
  end
end
