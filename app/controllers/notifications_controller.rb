class NotificationsController < ApplicationController
 
  skip_before_action :verify_authenticity_token
 
  def notify
    # phone_number = []
    # phone_number = params[:phone_number].split(",")

    text_message = params[:text_message]
   

    phone_number = ['(678)491-7762']
      # , '(404)641-7242']
    phone_number.each do |i|

    client = Twilio::REST::Client.new Rails.application.secrets.twilio_account_sid, Rails.application.secrets.twilio_auth_token
    message = client.messages.create from: '(678)212-5314', to: i, body: text_message  

    end

    render :notify
  end
 
  def incoming
    render plain: "Received"
  end
end
