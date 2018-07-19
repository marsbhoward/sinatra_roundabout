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
    if !params[:project_name].empty?

    #  if Project.exists?(project_name: (params[:project_name]))
        @Project = @user.projects.create(project_name: params[:project_name])
        erb :'projects/projects'
    #  end
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

  get '/projects/:id' do
    if Helpers.is_logged_in?(session)
      @project = Project.find_by(id: params[:id])
      erb :'projects/show'
    else
      redirect '/login'
    end
  end

  post '/projects/:id/delete' do
    @project = Project.find_by(id: params[:id])
    @project.delete if @project.user == Helpers.current_user(session)
    redirect '/projects'
  end

  get '/projects/:id/edit' do
    if Helpers.is_logged_in?(session)
      @project = Project.find_by(id: params[:id])
      erb :'projects/edit_projects'
    else
      redirect '/login'
    end
  end

  post '/projects/:id/edit' do
    @project = Project.find_by(id: params[:id])
    @project.update(content: params[:content])
    @project.save
  end
end
