require "rails_helper"

RSpec.describe Visitor do
  let(:visitor_params) { {email: 'user@example.com'}}
  let(:visitor) { Visitor.new visitor_params }

  context 'creation' do
    it 'is valid when created with valid parameters' do
      expect(visitor).to be_valid
    end

    it 'is invalid without an email' do
      # Delete email before visitor let is called
      visitor_params.delete :email
      expect(visitor).not_to be_valid # Must not be valid without email
      expect(visitor.errors).to include(:email) # Must have error for missing email
    end
    it 'is invalid with an invalid email' do
      visitor_params[:email] = 'invalid@email'
      expect(visitor).not_to be_valid
    end
  end

  context 'subscription' do
    let(:mailchimp) { double('Gibbon::Request').as_null_object }
    let(:mailchimp_hash_request) { {body: {:email_address => 'user@example.com', :status => 'subscribed'} } }


    before do
      visitor.mailchimp = mailchimp
    end

    it 'creates a new member' do
      expect(mailchimp.lists(nil).members).to receive(:create).with(mailchimp_hash_request)
      visitor.subscribe
    end

    it 'returns the detail when an exception is thrown' do
      exception = Gibbon::MailChimpError.new
      exception.detail = 'test detail'

      allow(mailchimp.lists(nil).members).to receive(:create).and_raise(exception)

      response = visitor.subscribe
      expect(response).to eq('test detail')
    end
  end
end