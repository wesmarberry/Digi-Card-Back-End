
class ApplicationController < Sinatra::Base
  require 'bundler'
  Bundler.require()

  require 'net/http'
  
  require 'dotenv'
  # require './config/environments'

  Dotenv.load()

  use Rack::Session::Cookie,  :key => 'rack.session',
                              :path => '/',
                              :secret => 'ashfjoaifjc'

  use Rack::MethodOverride
  set :method_override, true

  

#splash page route
  get '/' do    
    redirect '/users/login'
  end


  get '/test' do
    some_text = "test working"
    binding.pry 
    "pry has finished -- here's some_text #{some_text}"
  end

  get '*' do
     halt 404
    
  end

end