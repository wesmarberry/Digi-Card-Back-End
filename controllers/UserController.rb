


class UserController < ApplicationController
	require 'bundler'
	Bundler.require

	# db connection
	# ActiveRecord::Base.establish_connection(
	# 	:adapter => 'postgresql',
	# 	:database => 'users'
	# )



	

	post '/register' do 

		user = User.find_by username: params[:username]

		if !user
			
			content_type :json
			user = User.new
			user.username = params[:username]
			user.password = params[:password]
			user.save
				session[:logged] = true
				session[:username] = user.username
				session[:user_id] = user.id
				session[:search] = 0
				session[:message] = {
					success: true,
					message: "#{user.username} has successfully logged in!"
			}
			{ :username => user.username}.to_json
		else
			session[:attempted_reg] = true
			content_type :json
    		{ :message => 'failed to register'}.to_json

		end
	end

	post '/login' do
		user = User.find_by username: params[:username]
		pw = params[:password]
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
				:message => "#{user.username} has successfully logged in!"
			}
			data.to_json
		end
	end





	





end