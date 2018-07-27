class Helpers
  def self.current_user(session)
    @user = User.find_by(id: session[:id])
  end

  def self.is_logged_in?(session)
    !User.find_by(id: session[:id]).nil?
  end

  def self.current_project(session)
    @project = Project.find_by(project_id: session[:project_id])
  end
end
