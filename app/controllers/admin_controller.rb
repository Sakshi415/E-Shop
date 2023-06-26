class AdminController < ApplicationController
   before_action :authenticate_user!
   before_action :check_admin_role
      
    def add_product_to_category
        category = Category.find(params[:category_id])
        product = Product.new(name: params[:name], price: params[:price], description: params[:description])
        category.products << product
        product.save!
        category.save!
        render json: { message: "Product added to category successfully" }
    end
      
    private
      
    def check_admin_role
        unless current_user.has_role?(:admin)
            render json: { error: "You must be an admin to perform this action" }, status: :unauthorized
        end
    end
end
