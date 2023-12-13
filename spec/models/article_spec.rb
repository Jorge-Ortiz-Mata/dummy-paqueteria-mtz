require 'rails_helper'

RSpec.describe Article, type: :model do
  let(:article_one) { build(:article, :with_attributes) }
  let(:article_two) { build(:article, :with_attributes, name: 'Iphone 14', price: 799.99) }
  let(:article_three) { build(:article, :with_attributes, name: 'Iphone 15', price: 599.99) }
  let(:invalid_article) { build(:article) }

  describe 'instances' do
    it 'should be a valid instance' do
      expect(article_one).to be_valid
    end

    it 'should not be a valid instance' do
      expect(invalid_article).to be_invalid
    end
  end

  describe 'scopes' do
    before do
      article_one.save
      article_two.save
      article_three.save
      @articles = Article.all
    end

    it 'should return the articles with a similar name' do
      expect(@articles.count).to be_eql(3)
      expect(Article.search_with_name('Iph').count).to be_eql(2)
      expect(Article.search_with_name('Pl').count).to be_eql(1)
    end

    it 'should return the articles with a min price specified' do
      expect(@articles.count).to be_eql(3)
      expect(Article.with_min_price(@articles, 500.00).count).to be_eql(2)
      expect(Article.with_min_price(@articles, 700.00).count).to be_eql(1)
    end

    it 'should return the articles with a max price specified' do
      expect(@articles.count).to be_eql(3)
      expect(Article.with_max_price(@articles, 600.00).count).to be_eql(2)
      expect(Article.with_max_price(@articles, 400.00).count).to be_eql(1)
    end
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:price) }
    it { should validate_uniqueness_of(:name) }
  end

  describe 'attachments' do
    it { should have_one_attached(:avatar) }
    it { should have_one_attached(:promotional_video) }
    it { should have_many_attached(:images) }
  end

  describe 'associations' do
    it { should have_many(:article_sells) }
    it { should have_many(:sells).through(:article_sells) }
  end
end
