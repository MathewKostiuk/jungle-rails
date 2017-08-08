require 'rails_helper'

RSpec.feature "ProductDetails", type: :feature, js: true do
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

  scenario "They see a specific products details" do
    # ACT
    visit root_path



    find('.pull-right').click

    puts page.html

    sleep(5)
    # DEBUG
    save_screenshot
    expect(page).to have_css '.products-show'

    # VERIFY
  end

end
