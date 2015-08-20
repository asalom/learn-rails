class VisitorsController < ApplicationController
  def new
    @owner = Owner.new
    if params[:hola] then
      flash.now[:notice] = "This is a notice!"
      flash.now[:alert] = "This is an alert"
      flash.now[:warning] = "This is an warning"
    end
    # render 'visitors/new' # -> Implemented in superclass
  end
end
