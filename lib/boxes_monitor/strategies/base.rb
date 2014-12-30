require 'faraday'

module BoxesMonitor
  module Strategies
    # Base strategy for which all inherit from.
    class Base
      attr_reader :client

      def initialize
        @user_agent = "BoxesMonitor/#{BoxesMonitor::VERSION} "\
                      '(https://github.com/nickcharlton/boxes-monitor)'

        @client = Faraday.new
        @client.headers[:user_agent] = @user_agent
      end
    end
  end
end
