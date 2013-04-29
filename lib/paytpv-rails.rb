require 'paytpv/bankstore'
require "paytpv/options"
require "paytpv/signatures"
require "paytpv/version"
require "savon"

module Paytpv
  class << self
    include Paytpv::Bankstore
  end
end