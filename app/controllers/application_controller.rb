class ApplicationController < Sinatra::Base
  register Sinatra::ActiveRecordExtension

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

  get '/' do
    erb :index
  end

  get '/signup' do
    if Helpers.is_logged_in?(session)
      redirect '/projects'
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
    redirect '/projects'
  end



end
