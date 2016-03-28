class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: :create

  def create
    github = GithubService.new
    session[:token] = github.authenticate!(ENV['GITHUB_CLIENT'], ENV['GITHUB_SECRET'], params[:code])

    github_user = GithubService.new('access_token' => session[:token])
    session[:username] = github_user.get_username
    redirect_to '/'
  end
end