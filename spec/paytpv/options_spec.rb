# encoding: utf-8

require 'spec_helper'
require 'paytpv/options'
require 'paytpv-rails'

describe Paytpv::Options do
  
  
  it "should return the appropriate credentials" do
    
    Paytpv::Options.stub(:paytpv_client_code).and_return('test_code')
    Paytpv::Options.stub(:paytpv_terminal).and_return('test_terminal')
    Paytpv::Options.stub(:paytpv_password).and_return('test_password')
    Paytpv::Options.stub(:paytpv_url).and_return('test_url')
    Paytpv::Options.stub(:paytpv_wsdl).and_return('test_wsdl')
    
    creds = Paytpv::Options.credentials
    creds.should have_key :paytpv_client_code
    creds.should have_key :paytpv_terminal
    creds.should have_key :paytpv_password
    creds.should have_key :paytpv_url
    creds.should have_key :paytpv_wsdl
  end
  
end