class PagesController < ApplicationController
    def home       
        @random_product = Product.order('RANDOM()').first
    end

    def map 
        @user = current_user
    end
    
    def account
       
        @account = current_user
        @purchase = current_user.payments
    end
end
