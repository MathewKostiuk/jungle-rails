require 'rails_helper'

RSpec.feature "AddToCarts", type: :feature, js: true do
   # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    1.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario 'They can see an item has been added to cart' do
    # ACT
    visit root_path
    find('.btn', match: :first).click
    sleep(5)
    # DEBUG
    save_screenshot

    # VERIFY
    expect(page).to have_content('My Cart (1)')
  end
end
