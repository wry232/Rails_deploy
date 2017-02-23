# require 'rails_helper'
# RSpec.describe UsersController, type: :controller do
#   before do
#     @user = create_user
#   end
#   describe "when not logged in" do
#     before do
#       session[:user_id] = nil
#     end
#     it "cannot access show" do
#       get :show, id: @user
#       expect(response).to redirect_to('/sessions/new')
#     end
#     it "cannot access edit" do
#       get :edit_user, id: @user
#       expect(response).to redirect_to('/sessions/new')
#     end
#     it "cannot access update" do
#       patch :update, id: @user
#       expect(response).to redirect_to('/sessions/new')
#     end
#     it "cannot access destroy" do
#       delete :delete, id: @user
#       expect(response).to redirect_to('/sessions/new')
#     end
#   end
# end

require 'rails_helper'
RSpec.describe UsersController, type: :controller do
  # ...
  describe "when signed in as the wrong user" do
    before do
      @right_user = create_user 'julius', 'julius@lakers.com'
      @wrong_user = create_user 'whythe', 'bball@mancrush.com'
      session[:user_id] = @right_user.id
    end
    it "cannot access profile page another user" do
      get :edit_user, id: @wrong_user
      expect(response).to redirect_to("/users/#{@right_user.id}")
    end
    it "cannot update another user" do
      patch :update, id: @wrong_user
      expect(response).to redirect_to("/users/#{@right_user.id}")
    end
    it "cannot destroy another user" do
      delete :delete, id: @wrong_user
      expect(response).to redirect_to("/users/#{@right_user.id}")
    end
  end
end
