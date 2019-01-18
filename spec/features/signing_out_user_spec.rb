require 'rails_helper'

RSpec.feature 'Signing out' do
  before do
    @user = User.create(email: "kuba@wp.pl", password: "haslo123", password_confirmation: "haslo123")
    sign_in @user
  end

  scenario 'succesfully signs out user' do
    visit "/"
    click_link "Sign out"

    expect(page).to have_content("Signed out successfully.")
    expect(page).not_to have_content("Sign out")
  end

end
