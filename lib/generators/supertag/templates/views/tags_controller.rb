class TagController < ApplicationController

  def index
    @tags = Supertag::Tag.all
  end

  def show
    @tag = Supertag::Tag.find_by_name(params[:tag])
    @tagged = @tag.taggables if @tag
  end

end
