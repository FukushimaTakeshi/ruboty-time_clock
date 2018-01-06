require "ruboty/time_clock/actions/time_clock"

module Ruboty
  module Handlers
    class TimeClock < Base
      on /time_clock\z/i, name: 'time_clock', description: 'output time_clock result'
    end

    def time_clock(message)
      Ruboty::TimeClock::Actions::TimeClock.new(message).call
    end
  end
end
