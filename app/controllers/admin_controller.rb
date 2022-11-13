class AdminController < ApplicationController
    #before_action :require_admin 

    def pending_approvals 
        @products = Product.where(is_approved: false).order('created_at DESC')
    end

    def confirmed_approvals 
        @products = Product.where(is_approved: true).order('created_at DESC')
    end

    def seller
        @products =  Product.all
        #@product = Product.find(params[:id])
        #@seller = @product.user_id
        #@selling = Products.group(:user_id)
        
        @users = User.all

    end 


    def edit 
        @product = Product.find(params[:id])
    end

    def update 
        @product = Product.find(params[:id])
        @product.update(product_params)
        redirect_to admin_path, notice: 'Product is successfully updated.'
    end

    def approve_product
        @product = Product.find(params[:id])
        if @product.update_attribute(:is_approved, true)
            
            #redirect_to admin_pending_products_path, notice: 'Product approved'
            redirect_to @product, notice: 'Product approved.'
        end
    end

    def reject_product
        @product = Product.find(params[:id])
        if @product.update_attribute(:is_approved, false)
            @product.destroy 
            #redirect_to admin_pending_approvals_path, notice: 'Product rejected.'
            #flash.now[:success] = "Product rejected."
            redirect_to request.referrer, notice: 'Product rejected.'
        end
    end 

    private 

    def product_params
        params.require(:product).permit(:is_approved) 
    end 

end
