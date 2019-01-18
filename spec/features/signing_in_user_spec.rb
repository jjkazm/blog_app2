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
    click_button "Log in"

    expect(page).to have_content("Signed in successfully.")
    expect(page).to have_content("Signed in as #{@user.email}")
    expect(page).not_to have_link("Login")
    expect(page).not_to have_link("Signup")
    expect(page.current_path).to eq(root_path)
  end

  scenario 'User fails sign in with invalid credentials' do
    visit '/'
    click_link "Login"

    fill_in "Email", with: ""
    fill_in "Password", with: ""
    click_button "Log in"

    expect(page).to have_content("Invalid Email or password.")
    expect(page).not_to have_content("Signed in as #{@user.email}")
    expect(page).to have_link("Login")
    expect(page).to have_link("Signup")
    expect(page.current_path).to eq(new_user_session_path)
  end
end
