class NotificationsController < ApplicationController
 
  skip_before_action :verify_authenticity_token
 
  def notify
    client = Twilio::REST::Client.new Rails.application.secrets.twilio_account_sid, Rails.application.secrets.twilio_auth_token
    message = client.messages.create from: '(678) 212-5314', to: '(678) 491-7762', body: 'Learning to send SMS you are.', media_url: 'http://linode.rabasa.com/yoda.gif'

    render :notify
  end
 
end
