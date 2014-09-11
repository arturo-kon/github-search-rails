module Omniauth

  module Mock
    def auth_mock
      OmniAuth.config.mock_auth[:github] = {
        'provider' => 'github',
        'uid' => '123545',
        'info' => {
          'name' => 'mockuser'
        },
        'credentials' => {
          'token' => 'mock_token'
        }
      }
    end
  end

  module SessionHelpers
    def signin
      visit root_path
      expect(page).to have_content('Sign in')
      auth_mock
      click_link 'Sign in'
    end
  end

end
