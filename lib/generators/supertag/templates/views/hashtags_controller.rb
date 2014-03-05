class HashtagController < ApplicationController

  def index
    @hashtags = Supertag::Hashtag.all
  end

  def show
    @hashtag = Supertag::Hashtag.find_by_name(params[:hashtag])
    @hashtagged = @hashtag.hashtaggables if @hashtag
  end

end
