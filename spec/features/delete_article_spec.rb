require 'rails_helper'

RSpec.feature 'Deleting an article' do
  before do
    adam = User.create(email: "adam@wp.pl", password: "haslo123")
    sign_in adam
    @article = Article.create(title: "First Article", body: "This is body of the first article", user: adam)

  end

  scenario 'user deletes an article' do
    visit '/'

    click_link @article.title

    click_link "Delete Article"

    expect(page).to have_content("Article has been deleted")
    expect(page.current_path).to eq(articles_path)
  end

end
