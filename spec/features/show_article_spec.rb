require "rails_helper"

RSpec.feature "Show article" do

  before do
    @adam = User.create(email: "adam@wp.pl", password: "haslo123")
    @jurek = User.create(email: "jurek@wp.pl", password: "haslo123")
    @article = Article.create(title: "First Article", body: "This is body of the first article", user: @adam)
  end

  scenario "to non-signed user" do
    visit "/"

    click_link @article.title

    expect(page).to have_content(@article.title)
    expect(page).to have_content(@article.body)
    expect(current_path).to eq(article_path(@article))
    expect(page).not_to have_link("Edit Article")
    expect(page).not_to have_link("Delete Article")
  end

  scenario "when signed user is author of the post" do
    sign_in @adam
    visit "/"

    click_link @article.title

    expect(page).to have_content(@article.title)
    expect(page).to have_content(@article.body)
    expect(current_path).to eq(article_path(@article))
    expect(page).to have_link("Edit Article")
    expect(page).to have_link("Delete Article")
  end

  scenario "when signed user is not author of the post" do
    sign_in @jurek
    visit "/"

    click_link @article.title

    expect(page).to have_content(@article.title)
    expect(page).to have_content(@article.body)
    expect(current_path).to eq(article_path(@article))
    expect(page).not_to have_link("Edit Article")
    expect(page).not_to have_link("Delete Article")
  end

end
