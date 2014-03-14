module Ancor
  module CLI
    class Base < Thor
      class_option :debug, type: :boolean, default: false
      class_option :host, type: :string, default: 'localhost'
      class_option :port, type: :numeric, default: 3000

      private

      def connection
        @connection ||= Client.new({
          debug: options[:debug],
          host: options[:host],
          port: options[:port]
        })
      end
    end # Base
  end # CLI
end
