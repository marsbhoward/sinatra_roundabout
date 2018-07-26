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

  post '/projects' do
    @user = Helpers.current_user(session)
    if !params[:project_name].empty? && Project.where(project_name: params['project_name']).exists? == false
        @Project = @user.projects.create(project_name: params[:project_name])
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

  post '/projects/:project_id/delete' do
    @project = Project.find_by(project_id: params[:project_id])
    @project.delete if @project.user == Helpers.current_user(session)
    redirect '/projects'
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
    @project = Project.find_by(project_id: params[:project_id])
    @project.update(content: params[:content])
    @project.save
  end
end
