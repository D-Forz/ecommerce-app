class ProductsController < ApplicationController
  before_action :set_product, only: %i[show edit update destroy]
  skip_before_action :protect_pages, only: %i[index show]

  def index
    @categories = Category.order(name: :asc).load_async
    @pagy, @products = pagy_countless(FindProducts.new.call(product_params_index).load_async, items: 10)
  end

  def show; end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to @product, notice: t('.created')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize!(@product)
  end

  def update
    authorize!(@product)
    if @product.update(product_params)
      redirect_to @product, notice: t('.updated')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize!(@product)
    @product.destroy
    redirect_to products_path, status: :see_other, notice: t('.destroyed')
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params_index
    params.permit(:category_id, :min_price, :max_price, :query_text, :order_by, :page)
  end

  def product_params
    params.require(:product).permit(:title, :description, :price, :image, :category_id)
  end
end
