class ContactsController < ApplicationController
  def process_form
    flash[:notice] = "Thank you #{params[:contact][:name]}. I will contact you shortly"
    redirect_to static_path(:contact)
  end
end
