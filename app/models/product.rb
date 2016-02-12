class Product < ActiveRecord::Base
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :sale_price, numericality: {less_than_or_equal_to: :price}

  def self.sort(search_term, sort_by_column, current_page, per_page_count)
    where(["name || description ILIKE ?","%#{search_term}%"]).order("#{sort_by_column}").offset(current_page * per_page_count).limit(per_page_count)
  end

  before_validation :set_default

  # scope :updated_at, lamba {|date| where("updated_at > ?", date) }

  def self.most_recent_on_sale
    where.not("sale_price = price").order("updated_at, sale_price").limit(3)
  end

  private

  def set_default
    self.sale_price ||= self.price
  end
end
