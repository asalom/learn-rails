class VisitorsController < ApplicationController
  def new
    @owner = Owner.new
    # render 'visitors/new' # -> Implemented in superclass
  end
end
