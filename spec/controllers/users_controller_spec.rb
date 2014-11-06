require 'rails_helper'

RSpec.describe UsersController, :type => :controller do
  describe '#new' do
    it 'assigns a new user instance variable' do
      get :new
      expect(assigns(:user)).to be_a_new(User)
    end

    it 'renders a new template' do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe "#create" do 
    context 'with valid user params' do 
      def valid_request
        post :create, {user: {first_name: 'tam',
          last_name: 'kbeili',
          email: 'tam@codecore.ca',
          password: 'gg',
          password_confirmation: 'gg'}}
      end

      it 'saves a user record' do
        expect do
          valid_request    
        end.to change {User.count}.by(1)
      end

      #this above example could also be expect {valid request}.to change {User.count}.by(1)

      it 'redirects to root' do
        valid_request
        expect(response).to redirect_to(root_path)
      end

      it 'sets a flash message' do
        valid_request
        expect(flash[:notice]).to be
      end

      it 'renders a show page' do
      end
    end

    context 'with invalid user params' do
      def invalid_request
        post :create, {user: {first_name: "gg"}}
      end

      it 'does not save a new record' do 
        expect{invalid_request}.not_to change {User.count}
      end

      it 'renders new' do
        invalid_request
        expect(response).to render_template(:new)
      end

      it 'sets a flash alert' do
        invalid_request
        expect(flash[:alert]).to be 
      end
    end
  end
end
