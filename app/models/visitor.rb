class Visitor
  include ActiveModel::Model
  attr_accessor :email, :string
  validates_presence_of :email
  validates_format_of :email, with: /\A[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}\z/i

  attr_writer :mailchimp

  def mailchimp
    @mailchimp ||= Gibbon::Request.new(api_key: Rails.application.secrets.mailchimp_api_key)
  end

  def subscribe
    mailchimp_id = Rails.application.secrets.mailchimp_list_id
    begin
      result = @mailchimp.lists(mailchimp_id).members.create(
                                                            body: {
                                                                :email_address => self.email,
                                                                :status => 'subscribed'
                                                            }
      )
    rescue Gibbon::MailChimpError => exception
      return exception.detail
    end

    Rails.logger.info("Subscribed #{self.email} to MailChimp.") if result
  end
end