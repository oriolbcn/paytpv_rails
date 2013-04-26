module PaytpvRails
  module Generators
    class ConfigGenerator < Rails::Generators::Base
      desc 'Creates a PayTPV gem configuration file at config/paytpv.yml, and an initializer at config/initializers/paytpv.rb'
      
      def self.source_root
        @_paytpv_source_root ||= File.expand_path("../templates", __FILE__)
      end
      
      def create_config_file
        template 'paytpv.yml', File.join('config', 'paytpv.yml')
      end
      
      def create_initializer_file
        template 'initializer.rb', File.join('config', 'initializers', 'paytpv.rb')
      end
      
    end
  end
end