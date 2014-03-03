class UsertagController < ApplicationController

  def index
    @usertags = SimpleUsertag::Usertag.all
  end

  def show
    @usertag = SimpleUsertag::Usertag.find_by_name(params[:usertag])
    @usertagged = @usertag.usertaggables if @usertag
  end

end
