require 'rails_helper'

feature 'User Account' do
  let(:user){ FactoryGirl.create(:user) }
  scenario ' a new user signs up' do
    visit root_path
    click_link 'Login'
    click_link 'Sign Up Now'
    fill_in 'First name', with: 'John'
    fill_in 'Last name', with: 'Doe'
    fill_in 'Email', with: 'john@example.com'
    fill_in 'Password', with: 'foobar'
    fill_in 'Password confirmation', with: 'foobar'
    click_button 'Create my account'
    expect(page).to have_content('User created successfully')

  end
end
