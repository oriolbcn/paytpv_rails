require 'paytpv_rails/configurable'

module PaytpvRails
  module Bankstore  
    class << self  
      include PaytpvRails::Configurable

      def add_user(ds_merchant_pan, ds_merchant_expirydate, ds_merchant_cvv2, ds_original_ip)
        client = Savon.client(@paytpv_wdsl)

        response = client.request "add_user" do
         soap.body do |xml|
           xml.DS_MERCHANT_MERCHANTCODE(@paytpv_client)
           xml.DS_MERCHANT_TERMINAL(@paytpv_terminal)
           xml.DS_MERCHANT_PAN(ds_merchant_pan)
           xml.DS_MERCHANT_EXPIRYDATE(ds_merchant_expirydate)
           xml.DS_MERCHANT_CVV2(ds_merchant_cvv2)
           xml.DS_MERCHANT_MERCHANTSIGNATURE(PaytpvRails::Signatures.add_user_signature(@paytpv_client, ds_merchant_pan, ds_merchant_cvv2, @paytpv_terminal, @paytpv_password))
           xml.DS_ORIGINAL_IP(ds_original_ip)
         end
        end

        response = response.to_hash[:add_user_response]

        return response
      end

      def info_user(ds_iduser, ds_token_user, ds_original_ip)

        client = Savon.client(@paytpv_client)

        response = client.request "info_user" do
         soap.body do |xml|
           xml.DS_MERCHANT_MERCHANTCODE(@paytpv_client)
           xml.DS_MERCHANT_TERMINAL(@paytpv_terminal)
           xml.DS_IDUSER(ds_iduser)
           xml.DS_TOKEN_USER(ds_token_user)
           xml.DS_MERCHANT_MERCHANTSIGNATURE(PaytpvRails::Signatures.info_user_signature(@paytpv_client, ds_iduser, ds_token_user, @paytpv_terminal, @paytpv_password))
           xml.DS_ORIGINAL_IP(ds_original_ip)
         end
        end

        response = response.to_hash[:info_user_response]

        if response[:ds_merchant_pan].is_a? String
          return response
        else
          return false
        end
      end

      def execute_purchase(ds_iduser, ds_token_user, ds_merchant_amount, ds_merchant_order, ds_merchant_currency, ds_original_ip, ds_merchant_productdescription = "", ds_merchant_owner = "")

        client = Savon.client(@paytpv_wdsl)

        response = client.request "execute_purchase" do
         soap.body do |xml|
           xml.DS_MERCHANT_MERCHANTCODE(@paytpv_client)
           xml.DS_MERCHANT_TERMINAL(@paytpv_terminal)
           xml.DS_IDUSER(ds_iduser)
           xml.DS_TOKEN_USER(ds_token_user)
           xml.DS_MERCHANT_AMOUNT(ds_merchant_amount)
           xml.DS_MERCHANT_ORDER(ds_merchant_order)
           xml.DS_MERCHANT_CURRENCY(ds_merchant_currency)
           xml.DS_MERCHANT_MERCHANTSIGNATURE(PaytpvRails::Signatures.execute_purchase_signature(@paytpv_client + ds_iduser + ds_token_user +  @paytpv_terminal + ds_merchant_amount + ds_merchant_order + @paytpv_password))
           xml.DS_ORIGINAL_IP(ds_original_ip)
           xml.DS_MERCHANT_PRODUCTDESCRIPTION(ds_merchant_productdescription)
           xml.DS_MERCHANT_OWNER(ds_merchant_owner)
         end
        end

        response = response.to_hash[:execute_purchase_response]      

        return response    

      end
    end
  end
end