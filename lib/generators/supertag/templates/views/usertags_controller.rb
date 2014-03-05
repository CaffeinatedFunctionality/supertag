class UsertagController < ApplicationController

  def index
    @usertags = Supertag::Usertag.all
  end

  def show
    @usertag = Supertag::Usertag.find_by_name(params[:usertag])
    @usertagged = @usertag.usertaggables if @usertag
  end

end
