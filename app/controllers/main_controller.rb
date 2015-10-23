class MainController < ApplicationController
  
  def index
    if params[:first_formula].present? && params[:second_formula].present?
      @formulaes = [Formula.new(params[:first_formula]), Formula.new(params[:second_formula])]
    end
  end



end
