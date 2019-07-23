require 'sinatra/base'

# controllers
require './controllers/ApplicationController'
require './controllers/UserController'
require './controllers/CardController'
# models
require './models/UserModel'
require './models/CardModel'
# top level routing (specify which controllers to use)
map ('/') {
	run ApplicationController
}

map ('/users') {
	run UserController
}

map ('/cards') {
	run CardController
}