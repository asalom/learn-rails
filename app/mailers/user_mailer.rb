class UserMailer < ApplicationMailer
  default from: "no-reply@alexsalom.es"

  def contact_email(contact)
    @contact = contact
    mail(to: Rails.application.secrets.owner_email, from: @contact.email, :subject => "Website Contact")
  end
end
