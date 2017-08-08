require 'rails_helper'

RSpec.feature "UserLogins", type: :feature, js: true do
  before :each do
    User.create!({
      first_name: 'john',
      last_name: 'doe',
      email: 'john@doe.com',
      password: '123456',
      password_confirmation: '123456'
      })
  end

  scenario "User can login" do
    visit root_path
    find('.login').click
    sleep(5)
    puts page.html

    fill_in 'email', with: 'john@doe.com'
    fill_in 'password', with: '123456'
    click_button 'Submit'
    save_screenshot

    expect(page).to have_content('Logout')
  end
end
