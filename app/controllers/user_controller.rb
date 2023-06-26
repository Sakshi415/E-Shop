class UserController < ApplicationController
    before_action :authenticate_user!
    #before_action :require_admin, only:  [:add_product]

    def add_role
        if params.has_key?(:user) && params[:user][:role].present?
          @user.add_role params[:user][:role]
          return render json: {message: "#{params[:user][:role]} role created"}, status: :created
        else
          return render json: {message: "Role is required"}, status: :unprocessable_entity
        end
    end
      
    def buy_product
        product = Product.find(params[:product_id])
        if product.present?
          quantity = params[:quantity].to_i
          total_price = product.price * quantity
          shipping_address = params[:shipping_address]
          billing_address = params[:billing_address]
          pincode = params[:pincode]
          phone_number = params[:phone_number].to_s
          order = current_user.orders.create(product: product,quantity: quantity,total_price: total_price,shipping_address: shipping_address,billing_address: billing_address,pincode: pincode,phone_number: phone_number)

          if order.save
            if prod = product.present?
                prod  = false
            end
            product.save

            return render json: { message: "Product purchased successfully" }
          else
           return render json: { error: "Failed to purchase product" }, status: :unprocessable_entity
          end
        else
          return render json: { error: "This product is not available" }, status: :unprocessable_entity
        end
    end
      
    def add_product
        unless current_user.has_role?(:admin)
            return render json: { error: "You must be an admin to perform this action" }, status: :unauthorized
        end
      
        product = Product.new(name: params[:name], price: params[:price], description: params[:description])
      
        product.save!
      
        return render json: { message: "Product added successfully" }
    end

    private

    def require_admin
      unless current_user
        render json: { error: "You must be an admin to perform this action" }, status: :unauthorized
      end
    end

    
end
