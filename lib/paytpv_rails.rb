require 'paytpv_rails/bankstore'
require 'paytpv_rails/configurable'
require "paytpv_rails/default"
require "paytpv_rails/signatures"
require "paytpv_rails/version"
require "savon"

module PaytpvRails
  class << self
    include PaytpvRails::Configurable
  end
end

PaytpvRails.setup