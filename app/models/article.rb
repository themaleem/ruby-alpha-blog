class Article < ApplicationRecord
  belongs_to :user # foreign key field (many articles to one user)
  
  has_many :article_categories # many articles to many categories
  has_many :categories, through: :article_categories

  validates :title, presence: true, length: { minimum: 10, maximum: 100 }
  validates :description, presence: true, length: { minimum: 10, maximum: 100 }
end
