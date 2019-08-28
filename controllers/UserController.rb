


class UserController < ApplicationController
	require 'bundler'
	Bundler.require

	# db connection
	# ActiveRecord::Base.establish_connection(
	# 	:adapter => 'postgresql',
	# 	:database => 'users'
	# )



	

	post '/register' do 

		request.body.rewind
		request_payload = JSON.parse request.body.read
		puts 'this is request payload'
		puts request_payload["username"]
		user = User.find_by username: request_payload["username"]

		if !user
			
			content_type :json
			user = User.new
			user.username = request_payload["username"]
			user.password = request_payload["password"]
			user.email = request_payload["email"]
			user.save
				session[:logged] = true
				session[:username] = user.username
				session[:user_id] = user.id
				session[:search] = 0
				session[:message] = {
					success: true,
					message: "#{user.username} has successfully logged in!"
			}
			data = {
				:status => 200,
				:user => user,
				:message => "#{user.username} has successfully registered!"
			}
			data.to_json
		else
			session[:attempted_reg] = true
			content_type :json
    		data = {
				:status => 400,
				:message => "failed to register"
			}
			data.to_json

		end
	end

	post '/login' do
		
		request.body.rewind
		request_payload = JSON.parse request.body.read
		puts 'this is request payload'
		puts request_payload["username"]
		user = User.find_by username: request_payload["username"]
		puts user
		pw = request_payload["password"]
		if user && user.authenticate(pw)
			content_type :json
			session[:logged] = true
			session[:username] = user[:name]
			session[:user_id] = user[:id]
			session[:search] = 0
			session[:logged] = true
			session[:message] = {
				success: true,
				message: "#{user.username} has successfully logged in!"
			}
			data = {
				:status => 200,
				:user => user,
				:message => "#{user.username} has successfully logged in!"
			}
			data.to_json
		else
			session[:attempted_log] = true
			data = {
				:status => 400,
				:message => "Invalid Credentials"
			}
			data.to_json
		end
	end



	get '/' do 
		content_type :json
		all_users = User.all
		data = {
			:status => 200,
			:users => all_users
		}
		data.to_json
	end

	get '/:id' do
		user = User.find(params[:id])
		puts user
		data = {
			:status => 200,
			:user => user
		}
		data.to_json
	end

	put '/:id' do
		user = User.find(params[:id])
		user.username = params[:username]
		user.first_name = params[:first_name]
		user.last_name = params[:last_name]
		user.email = params[:email]
		user.website = params[:website]
		user.photo = params[:photo]
		user.linkedin = params[:linkedin]
		user.github = params[:github]
		user.phone = params[:phone]
		user.background = params[:background]

		user.save
		data = {
			:status => 200,
			:user => user,
			:message => "{#{user.username} has bee updated"
		}
		data.to_json
	end




end