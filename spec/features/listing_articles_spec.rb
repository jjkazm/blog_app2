require 'rails_helper.rb'

RSpec.feature "Listing Articles" do

  before do
    adam = User.create(email: "adam@wp.pl", password: "haslo123")
    sign_in adam
    @article1 = Article.create(title: "First Article", body: "This is body of the first article", user: adam)
    @article2 = Article.create(title: "Second Article", body:"This is body of the second article", user: adam)
  end

  scenario "A user list all articles" do
    visit "/"

    expect(page).to have_content(@article1.title)
    expect(page).to have_content(@article1.body)
    expect(page).to have_content(@article2.title)
    expect(page).to have_content(@article2.body)
    expect(page).to have_link(@article1.title)
    expect(page).to have_link(@article2.title)
  end


  scenario "User has no articles" do
    Article.delete_all

    visit "/"

    expect(page).not_to have_content(@article1.title)
    expect(page).not_to have_content(@article1.body)
    expect(page).not_to have_content(@article2.title)
    expect(page).not_to have_content(@article2.body)
    expect(page).not_to have_link(@article1.title)
    expect(page).not_to have_link(@article2.title)

    within ("h1#no-articles") do
      expect(page).to have_content("No Articles Created")
    end

  end

end
