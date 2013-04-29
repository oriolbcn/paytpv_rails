module Paytpv
  module Options
    class << self
    
      # Convenience method to allow configuration options to be set in a block
      def configure
        yield self
        self
      end
    
      def credentials?
        credentials.values.all?
      end

      # @return [Hash]
      def credentials
        {
          :paytpv_client_code => paytpv_client_code,
          :paytpv_terminal => paytpv_terminal,
          :paytpv_password => paytpv_password,
          :paytpv_url => paytpv_url,
          :paytpv_wsdl => paytpv_wsdl, 
        }
      end
    
      private
        
      # @return [String]
      def paytpv_client_code
        PAYTPV_CONFIG['paytpv_client_code']
      end

      # @return [String]
      def paytpv_terminal
        PAYTPV_CONFIG['paytpv_terminal']
      end

      # @return [String]
      def paytpv_password
        PAYTPV_CONFIG['paytpv_password']
      end

      # @return [String]
      def paytpv_url
        PAYTPV_CONFIG['paytpv_url']
      end

      # This is configurable
      def paytpv_wsdl
        PAYTPV_CONFIG['paytpv_client_wsdl'] || "https://www.paytpv.com/gateway/xml_bankstore.php?wsdl"
      end
      
    end
  end
end