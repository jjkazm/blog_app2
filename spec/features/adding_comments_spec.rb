require 'rails_helper'

RSpec.feature "Adding Comments to Articles" do

  before do
    @adam = User.create(email: "adam@wp.pl", password: "haslo123")
    @jurek = User.create(email: "jurek@wp.pl", password: "haslo123")
    @article = Article.create!(title: "First Article", body: "This is body of the first article", user: @adam)
  end

  scenario 'permits signed user to create comment' do
    login_as @jurek

    visit "/"

    click_link "#{@article.title}"
    fill_in "New Comment", with: "An amazing article"
    click_button "Add Comment"

    expect(page).to have_content("Comment has been created")
    expect(page).to have_content("An amazing article")
    expect(current_path).to eq(article_path(@article))
  end

end
