class UserController < ApplicationController

  get '/signup' do
    if Helpers.is_logged_in?(session)
      redirect '/users/index'
    else
      erb :'users/signup'
    end
  end

  post '/signup' do
    if params['username'].empty? || params['password'].empty? || params['email'].empty?


      redirect '/signup', info: "Invalid email or password"

    elsif User.where(username: params['username']).exists? == true

      redirect '/signup', info: "Invalid email or password"

    elsif User.where(email: params['email']).exists? == true
      redirect '/signup'

    else
      @user = User.new(username: params['username'], email: params['email'], password: params['password'])
      @user.save
      session[:id] = @user.id
      session[:username] = @user.username
    end
    redirect '/users/index'
  end

  get '/login' do
    if Helpers.is_logged_in?(session)
      redirect '/users/index'
    else
      erb :'users/login'
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:id] = @user.id
      session[:username] = @user.username
      redirect '/users/index'
    else
      redirect '/signup'
    end
  end

  get '/logout' do
    if Helpers.is_logged_in?(session)
      session.clear
      redirect '/'
    else
      redirect '/signup'
    end
  end

  get '/users/index' do
    erb :'users/index'
  end



end
