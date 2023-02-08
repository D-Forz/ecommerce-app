class ProductsController < ApplicationController
  before_action :set_product, only: %i[show edit update destroy]
  def index
    @categories = Category.order(name: :asc).load_async
    @products = Product.with_attached_image.order(created_at: :desc).load_async

    if params[:category_id]
      @products = @products.where(category_id: params[:category_id])
    end
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

  def edit; end

  def update
    if @product.update(product_params)
      redirect_to @product, notice: t('.updated')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @product.destroy
    redirect_to products_path, status: :see_other, notice: t('.destroyed')
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:title, :description, :price, :image, :category_id)
  end
end
