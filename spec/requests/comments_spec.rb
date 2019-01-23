require 'rails_helper'

RSpec.describe 'Comment', type: :request do

  before do
    @adam = User.create(email: "adam@wp.pl", password: "haslo123")
    @jurek = User.create(email: "jurek@wp.pl", password: "haslo123")
    @article = Article.create!(title: "This is article title", body: "This is article body", user: @adam)
  end

  describe 'POST /articles/:article_id/comments' do
    context 'by not signed user' do
      before do
        post "/articles/#{@article.id}/comments", params: {comment: { body: "This is new comment"}}
      end
      it 'redirects to sign in page' do
        expect(response).to redirect_to(new_user_session_path)
        expect(response.status).to eq 302
        expect(flash[:alert]).to eq "You need to sign in or sign up before continuing."
      end
    end
    context 'by signed in user' do
      before do
        login_as @jurek
        post "/articles/#{@article.id}/comments", params: {comment: { body: "This is new comment"}}
      end
      it 'posts the comment' do
        expect(response.status).to eq 200
        # expect(flash[:notice]).to eq "Comment has been created"
      end
    end
  end
end
