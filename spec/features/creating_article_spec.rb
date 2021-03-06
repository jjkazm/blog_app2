require 'rails_helper'

RSpec.feature "Creating article" do

  before do
    @user = User.create(email: "kuba@wp.pl", password: "haslo123", password_confirmation: "haslo123")
    sign_in @user
  end

  scenario "user creates new article" do
    visit "/"

    click_link "New Article"

    fill_in "Title", with: "Creating a blog"
    fill_in "Body", with: "Lorem Ipsum"

    click_button "Create Article"

    puts page
    expect(Article.last.user).to eq(@user)
    expect(page).to have_content("Article has been created")
    expect(page).to have_content("Created by #{@user.email}")
    expect(page.current_path).to eq(articles_path)
  end

  scenario "user fails with empty title and body" do
     visit "/"

     click_link "New Article"

     fill_in "Title", with: ""
     fill_in "Body", with: ""

     click_button "Create Article"

     expect(page).to have_content("Article has not been created")
     expect(page).to have_content("Title can't be blank")
     expect(page).to have_content("Body can't be blank")
  end

end
