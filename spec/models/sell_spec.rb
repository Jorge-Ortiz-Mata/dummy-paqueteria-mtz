require 'rails_helper'

RSpec.describe Sell, type: :model do
  let(:sell_default) { build(:sell, :with_attributes) }
  let(:invalid_sell) { build(:sell) }
  let(:article_one) { build(:article, :with_attributes) }
  let(:sell_one) { build(:sell, :with_attributes, date_of_sell: '2023-09-09') }
  let(:sell_two) { build(:sell, :with_attributes, date_of_sell: '2023-08-08') }
  let(:article_sell_one) { build(:article_sell, :with_attributes) }
  let(:article_sell_two) { build(:article_sell, :with_attributes, quantity: 10) }

  describe 'instances' do
    it 'should be a valid instance' do
      expect(sell_default).to be_valid
    end

    it 'should be an invalid instance' do
      expect(invalid_sell).to be_invalid
    end
  end

  describe 'scopes' do
    before do
      article_one.save
      sell_one.save
      sell_two.save
      @sells = Sell.all
    end

    it 'should filter the sells by a date minimum' do
      expect(@sells.count).to be_eql(2)
      expect(Sell.filter_with_date_min(@sells, '2023-09-01'.to_date).count).to eql(1)
      expect(Sell.filter_with_date_min(@sells, '2023-09-10'.to_date).count).to eql(0)
    end

    it 'should filter the sells by a date maximum' do
      expect(@sells.count).to be_eql(2)
      expect(Sell.filter_with_date_max(@sells, '2023-08-08'.to_date).count).to eql(1)
      expect(Sell.filter_with_date_max(@sells, '2023-06-06'.to_date).count).to eql(0)
    end
  end

  describe 'validations' do
    it { should validate_presence_of(:date_of_sell) }
  end

  describe 'custom validations' do
    it 'should return error if date of sell is greater than today' do
      sell_one.date_of_sell = Date.today + 2.day

      expect(sell_one).to be_invalid
    end
  end

  describe 'associations' do
    it { should have_many(:article_sells) }
    it { should have_many(:articles).through(:article_sells) }
  end

  describe 'callbacks' do
    it 'should delete all the articles_sells associations if the sell is deleted' do
      article_one.save
      sell_one.save

      sell_one.article_sells.create(article: article_one, quantity: 5)
      sell_one.article_sells.create(article: article_one, quantity: 15)

      expect(ArticleSell.count).to be_eql(2)

      sell_one.destroy

      expect(ArticleSell.count).to be_eql(0)
    end
  end

  describe 'class methods' do
    it 'should return the latest sells with the total revenue by day' do
      article_one.save
      sell_one.date_of_sell = Date.today
      sell_one.save

      article_sell_one.sell = sell_one
      article_sell_one.article = article_one
      article_sell_one.save

      article_sell_two.sell = sell_one
      article_sell_two.article = article_one
      article_sell_two.save


      expect(Sell.revenue_by_day.length).to be_eql(30)
      expect(Sell.revenue_by_day[0].length).to be_eql(2)
      expect(Sell.revenue_by_day[0].last).to be_eql(5_994.9)
    end
  end
end
