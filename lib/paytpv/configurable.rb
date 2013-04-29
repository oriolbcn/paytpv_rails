module Paytpv
  module Configurable
    
    attr_writer :paytpv_client, :paytpv_terminal, :paytpv_password, :paytpv_url, :paytpv_wdsl
    
    class << self
      def keys
        @keys ||= [
          :paytpv_client,
          :paytpv_terminal,
          :paytpv_password,
          :paytpv_url,
          :paytpv_wdsl,
        ]
      end
    end  
    
    # Convenience method to allow configuration options to be set in a block
    def configure
      yield self
      self
    end
    
    def credentials?
      credentials.values.all?
    end
    
    def reset!
      Paytpv::Configurable.keys.each do |key|
        instance_variable_set(:"@#{key}", Paytpv::Default.options[key])
      end
      self
    end
    alias setup reset!

    private

    # @return [Hash]
    def credentials
      {
        :paytpv_client => @paytpv_client,
        :paytpv_terminal => @paytpv_terminal,
        :paytpv_password => @paytpv_password,
        :paytpv_url => @paytpv_url,
        :paytpv_wdsl => @paytpv_wdsl, 
      }
    end

    # @return [Hash]
    def options
      Hash[Paytpv::Configurable.keys.map{|key| [key, instance_variable_get(:"@#{key}")]}]
    end
      
  end
end