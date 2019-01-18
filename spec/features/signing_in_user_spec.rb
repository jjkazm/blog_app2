require 'rails_helper'

RSpec.feature 'Users signin' do
  before do
    @user = User.create(email: "kuba@wp.pl", password: "haslo123", password_confirmation: "haslo123")
  end

  scenario 'User sign in succesfully with valid credentials' do
    visit '/'
    click_link "Login"

    fill_in "Email", with: "kuba@wp.pl"
    fill_in "Password", with: "haslo123"
    click_button "Login"

    expect(page).to have_content("Signed in succesfully.")
    expect(page).to have_content("Signed in as #{@user.email}")
    expect(page).not_to have_link("Login")
    expect(page).not_to have_link("Signup")
    expect(page.current_path).to eq(articles_path)
  end
end
