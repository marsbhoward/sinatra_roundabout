require './config/environment'

class ProjectController < ApplicationController

  get '/projects' do
    if Helpers.is_logged_in?(session)
      @projects = Project.all
      erb :'projects/projects'
    else
      redirect '/login'
    end
  end

  get 'projects/projects' do
   if Helpers.is_logged_in?(session)
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

  get '/projects/:project_id' do
    if Helpers.is_logged_in?(session)
      @user = Helpers.current_user(session)
      @project = Helpers.current_project(session)
      erb :'projects/projects'
    else
      redirect '/login'
    end
  end

  get '/projects/:project_id/show' do
    if Helpers.is_logged_in?(session)
      @user = Helpers.current_user(session)
      @project = Helpers.current_project(session)
      erb :'/projects/show'
    else
      redirect '/login'
    end
  end

  post '/projects/:project_id/delete' do
    if Helpers.is_logged_in?(session)
      @project = Project.find_by(project_id: params[:project_id])
      @project.destroy
    else
      redirect '/login'
    end
  end

  get '/projects/:project_id/edit' do
    if Helpers.is_logged_in?(session)
      @project = Helpers.current_project(session)
      #@project = Project.find_by(project_id: params[:project_id])
      erb :'projects/edit_projects'
    else
      redirect '/login'
    end
  end

  post '/projects/:project_id/edit' do
    @project = Project.find_by(project_name: session[:project_name])
    @project.update(description: params[:description] ,content: params[:content])
    @project.save
    erb :'/users/index'
  end
end
