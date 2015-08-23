require 'twilio-ruby'

class TextResponseController < ApplicationController
   include Webhookable

  def incoming

  def respond
      response = Twilio::TwiML::Response.new do |r|
        body_request = params[:Body]
        if body_request == "Hey8"
          r.Message "Hey Monkey8. Thanks for the message!"
        else
          r.Message "Hey MonkeyX.  Thanks for the message!"
        end
      end
      render_twiml response
  end

end