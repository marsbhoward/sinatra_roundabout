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
      redirect '/signup'
    else
      @user = User.new(username: params['username'], email: params['email'], password: params['password'])
      @user.save
      session[:id] = @user.id
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
      redirect '/users/index'
    else
      redirect '/signup'
    end
  end

  get '/logout' do
    if Helpers.is_logged_in?(session)
      session.clear
      redirect '/login'
    else
      redirect '/'
    end
  end

  get '/users/index' do
    erb :'users/index'
  end

  post '/index/users' do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:id] = @user.id
      redirect '/projects/index'
    else
      redirect '/signup'
    end
  end

end
