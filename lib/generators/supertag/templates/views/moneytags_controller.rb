class MoneytagsController < ApplicationController
  def index
    @moneytags = Supertag::Moneytag.all
  end

  def show
    @moneytag = Supertag::Moneytag.find_by_name(params[:moneytag])
    @moneytagged = @moneytag.moneytaggables if @moneytag
  end
end