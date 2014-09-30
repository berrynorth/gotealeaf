class Category < ActiveRecord::Base
  include Sluggable

  has_many :post_categories
  has_many :posts, through: :post_categories

  validates :name, presence:   true,
                   length:     {maximum: 25},
                   uniqueness: {case_sensitive: false}

  after_validation :to_title

  sluggable_column :name

  def to_title
    self.name = self.name.titleize
  end
end