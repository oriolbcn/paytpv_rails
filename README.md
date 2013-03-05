Paytpv Rails
============

Esta gema pretende facilitar la integración con PayTPV en cualquier proyecto RoR.

* Esta gema NO es "oficial" ni está respaldada ni supervisada por PayTPV. 
* Este gema está en fase de desarrollo. Si la usas en entornos de producción es bajo tu responsabilidad.
* Sólo ha sido probada con Rails 3.x y ruby 1.9.2 - 1.9.3
* De momento sólo han sido integradas 3 acciones de las opciones que ofrece PayTPV (add_user, info_user y execute_purchase). Seguiremos añadiendo nuevas opciones conforme lo vayan requiriendo nuestros proyectos.

Installation
-------------

Install paytpv_rails like any other Ruby gem:

    gem install paytpv_rails

Or, if you're using Rails/Bundler, add this to your Gemfile:

    gem "paytpv_rails"

and run at the command prompt:

    bundle install
    
Configuration
--------------

Define Paytpv product configuration options as a block to the PaytpvRails.configure method.

      PaytpvRails.configure do |config|
        config.paytpv_client = "paytpv_client"
        config.paytpv_terminal = "paytpv_terminal"
        config.paytpv_password = "paytpv_password"
        config.paytpv_wdsl = "https://www.paytpv.com/gateway/xml_bankstore.php?wsdl"
      end

You can also configure environment variables:
      
      PAYTPV_CLIENT
      PAYTPV_TERMINAL
      PAYTPV_PASSWORD
      PAYTPV_WDSL
      
User actions
-------------
### add_user

You can add new user to your PayTPV account by using "add_user" action like this (for example)

      class User < ActiveRecord::Base
      
        def add_user_to_paytpv
          response = PaytpvRails::Bankstore.add_user(ds_merchant_pan, ds_merchant_expirydate, ds_merchant_cvv2, ds_original_ip)      

          if response[:ds_error_id] == "0"
            self.ds_error_id = response[:ds_error_id]
          else
            self.ds_iduser = add_user[:ds_iduser]
            self.ds_token_user = add_user[:ds_token_user]
          end
        end
      
      end            

* ds_merchant_pan: Obligatorio. Número de tarjeta, sin espacios ni guiones // [0-9]{16,19}
* ds_merchant_expirydate: Obligatorio. Fecha de caducidad de la tarjeta, expresada como “mmyy” (mes en dos cifras y año en dos cifras) // [0-9]{4}
* ds_merchant_cvv2: Obligatorio. Código CVC2 de la tarjeta // [0-9]{3,4}
* ds_original_ip: Obligatorio. Dirección IP del cliente que inició la operación de pago (propietario de la tarjeta) // A.B.C.D

### info_user

You can get user information by using "info_user" action like this (for example)

      class User < ActiveRecord::Base
      
        def paytpv_user_info
          response = PaytpvRails::Bankstore.info_user(ds_iduser, ds_token_user, ds_original_ip)

          if response
            response[:ds_merchant_pan]
          else
            "Error" # catch the error here, no user found.
          end
        end
      
      end
      
* ds_iduser: Obligatorio. Identificador único del usuario registrado en el sistema. // [0-9]{1,13}
* ds_token_user: Obligatorio. Código token asociado al DS_IDUSER. // [0-9]{1,13}
* ds_original_ip: Obligatorio. Dirección IP de la aplicación del comercio. // A.B.C.D

Payment actions
----------------
### execute purchase

You can execute purchases to your "added" users by using "execute_purchase" action. For example:

      class Payment < ActiveRecord::Base
      
        def execute_purchase

          response = PaytpvRails::Bankstore.execute_purchase(ds_iduser, ds_token_user, ds_merchant_amount, ds_merchant_order, ds_merchant_currency, ds_original_ip, ds_merchant_productdescription, ds_merchant_owner)

          if response[:ds_error_id].is_a? String  
            self.ds_error_id = response[:ds_error_id]    
          else
            self.ds_merchant_amount = response[:ds_merchant_amount]
            self.ds_merchant_order = response[:ds_merchant_order]
            self.ds_merchant_currency = response[:ds_merchant_currency]
            self.ds_merchant_authcode = response[:ds_merchant_authcode]
            self.ds_merchant_cardcountry = response[:ds_merchant_cardcountry]      
          end

        end
      
      end
      
* ds_iduser: Obligatorio. Identificador único del usuario registrado en el sistema. // [0-9]{1,13}
* ds_token_user: Obligatorio. Código token asociado al DS_IDUSER. // [A-Za-z0-9]{1,20}
* ds_merchant_amount: Obligatorio. Importe de la operación en formato entero. 1,00 EURO = 100 // [0-9]{1,8}
* ds_merchant_order: Obligatorio. Referencia de la operación. Debe ser única en cada transacción válida. // [A-Za-z0-9]{1,20}
* ds_merchant_currency: Obligatorio. Moneda de la transacción // [EUR][USD][GBP][JPY]
* ds_original_ip: Obligatorio. Dirección IP de la aplicación del comercio // A.B.C.D
* ds_merchant_productdescription: Opcional. Descripción del producto // [a-zA-Z0-9]{40}
* ds_merchant_owner: Opcional. Descripción de la transacción // [a-zA-Z0-9]{40}
      
      
Disclaimer
-----------
* This gem is under development, use it in production environment under your own responsability
* There're only few paytpv actions implemented. We're adding more options, but we're busy, you know! :) 

Contributing to paytpv
--------------------------
 
* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet.
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it.
* Fork the project.
* Start a feature/bugfix branch.
* Commit and push until you are happy with your contribution.
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

Copyright
----------

Copyright (c) 2013 David Ramirez. See LICENSE.txt for
further details.