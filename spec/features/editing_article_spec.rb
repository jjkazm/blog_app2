require 'rails_helper'

RSpec.feature "Editing article" do
  before do
    @article = Article.create(title: "First Article", body: "This is body of the first article")
  end

  scenario "User updated article" do
    visit "/"

    click_link @article.title
    click_link "Edit Article"

    fill_in "Title", with: "Updated title"
    fill_in "Body", with: "Updated body article"
    click_button "Update Article"

    expect(page).to have_content("Updated title")
    expect(page).to have_content("Updated body article")
    expect(page).to have_content("Article has been updated")

    expect(page.current_path).to eq(article_path(@article))
  end

  scenario "User fails updating article with empty title and body" do
    visit "/"

    click_link @article.title
    click_link "Edit Article"

    fill_in "Title", with: ""
    fill_in "Body", with: ""
    click_button "Update Article"

    expect(page).to have_content("Article has been updated")
    expect(page.current_path).to eq(edit_article_path)
  end
end
