require "ruboty/time_clock/actions/time_clock"

module Ruboty
  module Handlers
    class TimeClock < Base
      on /chronus (?<id>.*?) (?<password>.*?) (?<start_time>.*?) (?<end_time>.*?)\z/, name: 'time_clock', description: 'output time_clock result'

      def time_clock(message)
        Ruboty::TimeClock::Actions::TimeClock.new(time_clock_params(message)).call
      end

      private

      def time_clock_params(message)
        id, password, start_time, end_time = message.match_data[1..4]
        {
          message: message,
          id: id,
          password: password,
          start_time: start_time,
          end_time: end_time
        }
      end
    end
  end
end
