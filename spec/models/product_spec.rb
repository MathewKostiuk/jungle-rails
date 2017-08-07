require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    it "is valid with valid attributes" do
      @category = Category.create! name: 'Category'
      @product = @category.products.create!({
        name: 'Name',
        price: 10,
        quantity: 10
        })
      expect(@product).to be_valid
    end
    it 'is invalid without name' do
      @category = Category.create! name: 'Category'
      @product = @category.products.create({
        name: '',
        price: 10,
        quantity: 10
        })
      expect(@product.errors.messages[:name]).to include("can't be blank")
    end
    it 'is invalid without price' do
      @category = Category.create! name: 'Category'
      @product = @category.products.create({
        name: 'name',
        quantity: 10
        })
      expect(@product.errors.messages[:price]).to include("can't be blank")
    end
    it 'is invalid without quantity' do
      @category = Category.create! name: 'Category'
      @product = @category.products.create({
        name: 'name',
        price: 10
        })
      expect(@product.errors.messages[:quantity]).to include("can't be blank")
    end
    it 'is invalid without category' do
      @product = Product.create({
        name: 'name',
        price: 10,
        quantity: 10
        })
      expect(@product.errors.messages[:category]).to include("can't be blank")
    end
  end
end
