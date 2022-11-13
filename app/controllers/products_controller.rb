class ProductsController < ApplicationController
    before_action :authenticate_user!, except: %i[index show]
    before_action :set_product, only: [:show]
    before_action :set_user_product, only: %i[edit update destroy]
    before_action :set_categories
 
    def index

      @products = Product.order('created_at desc').where('purchased = false').page params[:page]

      @products = @products.search(params[:search]) if params[:search].present?
      
      if params[:condition_id].present?
        @products = @products.condition_id(params[:condition_id])
      end
      if params[:category_id].present?
        @products = @products.category_id(params[:category_id])
      end
    end

    def sell 
      @product = Product.find(params[:id])
      @seller = @product.user_id
    end

    def smail 
      @product = Product.find(params[:id])
      @seller = @product.user_id
      @current_user = current_user
      InterestMailer.with(seller_id: @seller, current_user: @current_user).notify.deliver_now
      redirect_to request.referrer, notice: 'Interest mail sent to the seller!!'
    end
  
    def show
      @user = @product.user   
      if user_signed_in? && current_user != @product.user
        response = auspost_api_get
        @full_cost = @product.price + (@delivery_cost.to_f * 100)
        @session_id = session.id
      end
    end
  
    def new
      @product = Product.new
      @categories = Category.all
      @conditions = Condition.all
    end
  
    def edit
      @categories = Category.all
      @conditions = Condition.all
      @product = Product.find(params[:id])
    end
  
    def create
      @product = current_user.products.create(product_params)
      @product.location = current_user.postcode
      @product.purchased = false
  
      if @product.save
        redirect_to @product, notice: 'Product was successfully created, and waiting for approval.'
      else
        render :new
      end
    end
  
    def update
      if @product.update(product_params)
        redirect_to @product, notice: 'Product was successfully updated.'
      else
        render :edit
      end
    end
  
    def destroy
      @product = set_product
      @product.destroy if @product.present?
  
      redirect_to products_url, notice: 'Product was successfully destroyed.'
    end
  
    
    private

    def set_product
      @product = Product.find(params[:id])
    end
  
   
    def product_params
      params.require(:product).permit(:name, :price, :location, :description, :category_id, :condition_id, :picture)
    end
  
    
    def set_user_product
      @product = current_user.products.find_by_id(params[:id])
  
      redirect_to products_path if @product.nil?
    end

    def set_categories
      @categories = Category.all.order(:name)
    end 
  
   
    def auspost_api_get
      seller_postcode = @product.location
      buyer_postcode = current_user.postcode
  
      
      length = rand(5..25)
      width = rand(5..25)
      height = rand(5..25)
      weight = rand(1..10)
      
    end
end