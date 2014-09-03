require "rails_helper"

RSpec.describe UserMailer, :type => :mailer do
  let!(:user) { Fabricate(:user) }
  let!(:mail) { user.deliver_reset_password_instructions! }

  it "renders the subject" do
    expect(mail.subject).to eql("Your password has been reset")
  end

  it 'renders the receiver email' do
    expect(mail.to).to eql([user.email])
  end

  it 'renders the sender email' do
    expect(mail.from).to eql(['noreply@greenthumb.com'])
  end

  it 'assigns @confirmation_url' do
    expect(mail.body.encoded).to match("http://www.greenthumb.com/password_resets/#{user.reset_password_token}/edit")
  end
end