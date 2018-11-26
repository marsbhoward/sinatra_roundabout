require './config/environment'

class ProjectController < ApplicationController

  get 'projects' do
   if Helpers.is_logged_in?(session)
     @user = Helpers.current_user(session)
     erb :'projects/projects'
   else
     redirect '/login'
   end
 end

  post '/projects' do
    @user = Helpers.current_user(session)
    if !params[:project_name].empty? && Project.where(project_name: params['project_name']).exists? == false
        @Project = @user.projects.create(project_name: params[:project_name],description: params[:description],content: params[:content],contributors: session[:username])
        erb :'/projects/projects'
    else
      flash[:message] = "Please enter a valid project name."
      redirect '/projects/new'
    end
  end

  get '/projects/new' do
    if Helpers.is_logged_in?(session)
      erb :'projects/new'
    else
      redirect '/login'
    end
  end

  get '/projects/:project_name/show' do
    if Helpers.is_logged_in?(session)
      @user = Helpers.current_user(session)
      @project = Project.find_by(project_name: params[:project_name])
      erb :'/projects/show'
    else
      redirect '/login'
    end
  end

  delete '/projects/:project_name/delete' do
    if Helpers.is_logged_in?(session) && @user == @project.user_id
      @project = Helpers.current_project(session)
      @project.destroy
      erb :'users/index'
    else
      redirect '/login'
    end
  end

  get '/projects/:project_name/edit' do
    if Helpers.is_logged_in?(session) && @user == @project.user_id
      @project = Helpers.current_project(session)
      #@project = Project.find_by(project_id: params[:project_id])
      erb :'projects/edit_projects'
    else
      redirect '/login'
    end
  end

  patch '/projects/:project_name/edit' do
    @project = Helpers.current_project(session)
    @project.update(content: params[:content])
    @project.save
    erb :'/projects/show'
  end
end
