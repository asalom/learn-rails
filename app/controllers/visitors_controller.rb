class VisitorsController < ApplicationController
  def new
    @visitor = Visitor.new
  end

  def create
    @visitor = Visitor.new(secure_params)
    if @visitor.valid?
      result = @visitor.subscribe
      Rails.logger.debug "result #{result}"
      if result.is_a? String
        flash[:error] = result
      else
        flash[:notice] = "Signed up #{@visitor.email}."
      end
      redirect_to root_path
    else
      render :new
    end
  end

  private
  def secure_params
    params.require(:visitor).permit(:email)
  end
end
