describe SessionsController, :omniauth do

  before do
    request.env['omniauth.auth'] = auth_mock
  end

  describe "#create" do

    it "creates a user" do
      expect {post :create, provider: :github}.to change{ User.count }.by(1)
    end

    it "creates a session" do
      expect(session[:user_id]).to be_nil
      post :create, provider: :github
      expect(session[:user_id]).not_to be_nil
    end

    it "redirects to the home page" do
      post :create, provider: :github
      expect(response).to redirect_to '/search'
    end

  end

  describe "#destroy" do

    before do
      post :create, provider: :github
    end

    it "resets the session" do
      expect(session[:user_id]).not_to be_nil
      delete :destroy
      expect(session[:user_id]).to be_nil
    end

    it "redirects to the home page" do
      delete :destroy
      expect(response).to redirect_to root_url
    end
  end

end
