require "rails_helper"

RSpec.feature "Show article" do

  before do
    adam = User.create(email: "adam@wp.pl", password: "haslo123")
    sign_in adam
    @article = Article.create(title: "First Article", body: "This is body of the first article", user: adam)
  end

  scenario "User shows an article" do
    visit "/"

    click_link @article.title

    expect(page).to have_content(@article.title)
    expect(page).to have_content(@article.body)
    expect(current_path).to eq(article_path(@article))
  end
end
