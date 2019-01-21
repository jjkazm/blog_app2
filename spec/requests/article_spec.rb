require "rails_helper"

RSpec.describe "Article", type: :request do
  before do
    @adam = User.create(email: "adam@wp.pl", password: "haslo123")
    @jurek = User.create(email: "jurek@wp.pl", password: "haslo123")
    @article = Article.create!(title: "This is article title", body: "This is article body", user: @adam)
  end

  describe 'GET /articles/:id' do
    context 'with existing article' do
      before { get "/articles/#{@article.id}" }

      it 'handles existing article' do
        expect(response.status).to eq(200)
      end
    end

    context 'with non-existing article' do
      before { get "/articles/xxxx"}

      it 'handles non-existing article' do
        expect(response.status).to eq(302)
        flash_message = "The article you are looking for can't be found"
        expect(flash[:alert]).to eq(flash_message)
      end
    end
  end

  describe 'GET /articles/:id/edit' do

    context 'with not signed in user' do
      before { get "/articles/#{@article.id}/edit"}
      it 'redirects to signin page' do
        expect(response.status).to eq 302
        expect(flash[:alert]).to eq("You need to sign in or sign up before continuing.")
      end
    end

    context 'with user who is not owner of the article' do
      before do
        login_as(@jurek)
        get "/articles/#{@article.id}/edit"
      end
      it 'redirects to home page' do
        expect(response.status).to eq 302
        flash_message = "You can only edit your own article."
        expect(flash[:alert]).to eq(flash_message)
      end
    end

    context 'with user who is owner of the article' do
      before do
        login_as(@adam)
        get "/articles/#{@article.id}/edit"
      end
      it 'renders page succesfully' do
        expect(response.status).to eq(200)
      end
    end
  end

  describe 'DELETE articles/:id' do
    context 'with unsigned user' do
      before {delete "/articles/#{@article.id}"}
      it 'redirects to sign in page' do
        expect(response.status).to eq 302
        flash_message = "You need to sign in or sign up before continuing."
        expect(flash[:alert]).to eq(flash_message)
      end
    end

    context 'with user who is not owner' do
      before do
        login_as(@jurek)
        delete "/articles/#{@article.id}"
      end
      it 'redirects to home page'do
        expect(response.status).to eq 302
        flash_message = "You can only delete your own article."
        expect(flash[:alert]).to eq(flash_message)
      end
    end

    context 'with user who is owner' do
      before do
        login_as(@adam)
        delete "/articles/#{@article.id}"
      end
      it 'deletes succesfully'do
        expect(response.status).to eq 302
      end
    end

  end



end
