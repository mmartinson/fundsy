require 'rails_helper'

RSpec.describe SessionsController, :type => :controller do
  let(:user) {create(:user)}

  describe '#new' do
    it 'renders new template' do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe '#create' do
    context 'successful login' do
      def valid_request
        post :create, email: user.email,
                      password: user.password
      end

      it 'sets the session user_id varibale to user id' do
        valid_request
        expect(session[:user_id ]).to eq(user.id)
      end

      it 'redirects to root_path' do
        valid_request
        expect(response).to redirect_to root_path
      end

      it 'sets a flash message' do
        valid_request
        expect(flash[:notice]).to be
      end

    end

    context 'unsuccessful login' do
      def invalid_request
        post :create, email: nil, password: 'gg'
      end

      it 'sets a flash message' do
        invalid_request
        expect(flash[:alert]).to be
      end

      it 'renders the login page' do
        invalid_request
        expect(response).to render_template(:new)
      end

      it 'doesn\'t set the session user_id variable' do
        invalid_request
        expect(session[:user_id]).to_not be
      end

    end
  end

  describe '#destroy' do
    let(:user) {create(:user)}
    def destroy_session
      login(user)
      delete :destroy
    end

    it 'sets user_id to nil' do
      destroy_session      
      expect(session[:user_id]).to_not be
    end

    it 'redirects to root path' do
      destroy_session
      expect(response).to redirect_to root_path
    end

    it 'sets a flash message' do 
      destroy_session
      expect(flash[:notice]).to be
    end
  end
end
