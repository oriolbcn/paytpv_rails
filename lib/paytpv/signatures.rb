module Paytpv
  module Signatures
    extend self
    
    # signatures

    def execute_purchase_signature(paytpv_client, ds_iduser, ds_token_user,  paytpv_terminal, ds_merchant_amount, ds_merchant_order, paytpv_password)
      # SHA1(DS_MERCHANT_MERCHANT_CODE + DS_IDUSER + DS_TOKEN_USER + DS_MERCHANT_TERMINAL + DS_MERCHANT_AMOUNT + DS_MERCHANT_ORDER + PASSWORD)
      Digest::SHA1.hexdigest(paytpv_client + ds_iduser + ds_token_user +  paytpv_terminal + ds_merchant_amount.to_s + ds_merchant_order.to_s + paytpv_password)
    end

    def add_user_signature(paytpv_client, ds_merchant_pan, ds_merchant_cvv2, paytpv_terminal, paytpv_password)
      # SHA1(DS_MERCHANT_MERCHANT_CODE + DS_MERCHANT_PAN + DS_MERCHANT_CVV2 + DS_MERCHANT_TERMINAL + PASSWORD)
      Digest::SHA1.hexdigest(paytpv_client + ds_merchant_pan.to_s + ds_merchant_cvv2.to_s + paytpv_terminal + paytpv_password)    
    end

    def info_user_signature(paytpv_client, ds_iduser, ds_token_user, paytpv_terminal, paytpv_password)
      # SHA1(DS_MERCHANT_MERCHANT_CODE + DS_IDUSER + DS_TOKEN_USER + DS_MERCHANT_TERMINAL + PASSWORD)
      Digest::SHA1.hexdigest(paytpv_client + ds_iduser + ds_token_user + paytpv_terminal + paytpv_password)        
    end
  end
end