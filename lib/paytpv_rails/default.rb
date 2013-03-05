require 'paytpv_rails/configurable'
require 'paytpv_rails/version'

module PaytpvRails
  module Default
    class << self

      # @return [Hash]
      def options
        Hash[PaytpvRails::Configurable.keys.map{|key| [key, send(key)]}]
      end

      # @return [String]
      def paytpv_client
        ENV['PAYTPV_CLIENT']
      end

      # @return [String]
      def paytpv_terminal
        ENV['PAYTPV_TERMINAL']
      end

      # @return [String]
      def paytpv_password
        ENV['PAYTPV_PASSWORD']
      end

      # @return [String]
      def paytpv_url
        ENV['PAYTPV_URL']
      end

      # This is configurable
      def paytpv_wdsl
        ENV['PAYTPV_WDSL'] || "https://www.paytpv.com/gateway/xml_bankstore.php?wsdl"
      end

    end
  end
end