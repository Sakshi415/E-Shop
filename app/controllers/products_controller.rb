class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :update, :destroy]

  # GET /products
  def index
    @products = Product.all

    render json: @products
  end

  # GET /products/1
  def show
    @product = Product.find(params[:id])
    render json: @product
  end

  # POST /products
  def create
    @product = Product.new(product_params)

    if @product.save
      render json: @product, status: :created, location: @product
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /products/1
  def update
    if @product.update(product_params)
      render json: @product
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  # DELETE /products/1
  def destroy
    @product.destroy
  end

  def productcategory
    product_id = params[:product_id]
    category_id = params[:category_id]
    product = Product.find_by(id: product_id)
    unless product.present?
        return render json: { message: "Can not find any product by this id"}, status: :forbidden
    end
    category = Category.find_by(id: category_id)
    unless category.present?
        return render json: { message: "Can not find any category by this id"}, status: :forbidden
    end
    product_category = ProductCategory.new
    product_category.product = product
    product_category.category = category

    product_category.save!
    return render json: { message: "successfully created"}, status: :ok

  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def product_params
      params.require(:product).permit(:name, :description, :price)
    end
end
