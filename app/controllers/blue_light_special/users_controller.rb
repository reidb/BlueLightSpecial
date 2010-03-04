class BlueLightSpecial::UsersController < ApplicationController
  unloadable

  skip_before_filter :authenticate, :only => [:new, :create]
  before_filter :redirect_to_root,  :only => [:new, :create], :if => :signed_in?
  filter_parameter_logging :password

  def new
    @user = ::User.new(params[:user])
    render :template => 'users/new'
  end

  def create
    @user = ::User.new params[:user]
    if @user.save
      redirect_to(url_after_create)
    else
      render :template => 'users/new'
    end
  end

  private

  def url_after_create
    sign_in_url
  end
end
