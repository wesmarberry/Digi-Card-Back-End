class CardController < ApplicationController
	require 'bundler'
	Bundler.require

	# db connection
	# ActiveRecord::Base.establish_connection(
	# 	:adapter => 'postgresql',
	# 	:database => 'cards'
	# )



	

	get '/' do 
		content_type :json
		all_cards = Card.all
		puts all_cards
		data = {
			:status => 200,
			:users => all_cards
		}
		data.to_json
	end

	get '/:id' do
		content_type :json
		card = Card.find_by owner_id: params[:id]
		puts card
		if !card
			data = {
			:status => 400,
			:card => card
			}
			puts data
			data.to_json
		else 
			data = {
				:status => 200,
				:card => card
			}
			puts data
			data.to_json
		end 
		
	end

	post '/create' do 

		request.body.rewind
		request_payload = JSON.parse request.body.read
		puts 'this is request payload'
		puts request_payload
		created_card = Card.new
		created_card.first_name = request_payload["first_name"]
		created_card.last_name = request_payload["last_name"]
		created_card.website = request_payload["website"]
		created_card.photo = request_payload["photo"]
		created_card.linkedin = request_payload["linkedin"]
		created_card.github = request_payload["phone"]
		created_card.background = request_payload["background"]
		created_card.owner_id = request_payload["owner_id"]
		created_card.save
		puts created_card
		data = {
			:status => 200,
			:card => created_card
		}
		data.to_json

	end



	





end