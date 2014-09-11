require 'sinatra/base'

class FakeGitHub < Sinatra::Base
  get '/search_repositories' do
    json_response 200, 'repositories.json'
  end

  private

  def json_response(response_code, file_name)
    content_type :json
    status response_code
    File.open(File.dirname(__FILE__) + '/fixtures/' + file_name, 'rb').read
  end
end