class CardController < ApplicationController
	require 'bundler'
	Bundler.require

	# db connection
	ActiveRecord::Base.establish_connection(
		:adapter => 'postgresql',
		:database => 'cards'
	)



	

	get '/' do
		"Welcome to the Sinatra MVC App!"
	end





	





end