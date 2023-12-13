class InsurancePolicy < ApplicationRecord
  has_many :article_sells

  validates :percentage, :price, presence: true
end
