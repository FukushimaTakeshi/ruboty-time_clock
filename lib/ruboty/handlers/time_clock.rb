require "ruboty/time_clock/actions/time_clock"

module Ruboty
  module Handlers
    class Timeclock < Base
      on /time_clock (?<number>.*?)\z/, name: 'time_clock', description: 'output time_clock result'
    end

    def time_clock(message)
      Ruboty::Timeclock::Actions::Timeclock.new(message).call
    end
  end
end
