class FindProducts
  attr_reader :products

  def initialize(products = initial_scope)
    @products = products
  end

  def call(params = {})
    scoped = products
    scoped = filter_by_category_id(scoped, params[:category_id])
    scoped = filter_by_min_price(scoped, params[:min_price])
    scoped = filter_by_max_price(scoped, params[:max_price])
    scoped = filter_by_query_text(scoped, params[:query_text])
    scoped = filter_by_user_id(scoped, params[:user_id])
    scoped = filter_by_favorites(scoped, params[:favorites])
    sort(scoped, params[:order_by])
  end

  private

  def initial_scope
    Product.with_attached_image
  end

  def filter_by_category_id(scoped, category_id)
    return scoped if category_id.blank?

    scoped.where(category_id:)
  end

  def filter_by_min_price(scoped, min_price)
    return scoped if min_price.blank?

    scoped.where("price >= ?", min_price)
  end

  def filter_by_max_price(scoped, max_price)
    return scoped if max_price.blank?

    scoped.where("price <= ?", max_price)
  end

  def filter_by_query_text(scoped, query_text)
    return scoped if query_text.blank?

    scoped.search_full_text(query_text)
  end

  def filter_by_user_id(scoped, user_id)
    return scoped if user_id.blank?

    scoped.where(user_id:)
  end

  def filter_by_favorites(scoped, favorites)
    return scoped if favorites.blank?

    scoped.joins(:favorites).where(favorites: { user_id: Current.user.id })
  end

  def sort(scoped, order_by)
    order_by_query = Product::ORDER_BY.fetch(order_by&.to_sym, Product::ORDER_BY[:newest])
    scoped.order(order_by_query)
  end
end
