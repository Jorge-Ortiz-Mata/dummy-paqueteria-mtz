require 'rails_helper'

RSpec.describe ArticleSell, type: :model do
  let(:article_sell_default) { build(:article_sell, :with_attributes, :with_sell, :with_article) }
  let(:invalid_article_sell) { build(:article_sell) }

  describe 'instances' do
    it 'should be a valid instance' do
      expect(article_sell_default).to be_valid
    end

    it 'should not be a valid instance' do
      expect(invalid_article_sell).to be_invalid
    end
  end

  describe 'associations' do
    it { should belong_to(:article) }
    it { should belong_to(:sell) }
  end

  describe 'validations' do
    it { should validate_presence_of(:article_id) }
    it { should validate_presence_of(:quantity) }

    it 'should return error if quantity is less than 0' do
      article_sell_default.quantity = -1

      expect(article_sell_default).to be_invalid
    end
  end

  describe 'custom validations' do
    it 'should return error if the article is not present in the database' do
      article_sell_default.article_id = 999

      expect(article_sell_default).to be_invalid
    end
  end

  describe 'callbacks' do
    it 'should set the revenue automatically after adding the article' do
      expect(article_sell_default.revenue).to be_eql(0.0)

      article_sell_default.save

      expect(article_sell_default.revenue).to be_eql(1_998.3)
    end

    it 'should set the revenue automatically after updating the quantity with the article' do
      article_sell_default.save

      expect(article_sell_default.revenue).to be_eql(1_998.3)

      article_sell_default.update(quantity: 2)

      expect(article_sell_default.revenue).to_not be_eql(1_998.3)
      expect(article_sell_default.revenue.to_i).to be_eql(799.32.to_i)
    end
  end
end
