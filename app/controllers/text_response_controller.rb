require 'twilio-ruby'

class TextResponseController < ApplicationController
   include Webhookable
  def respond
      response = Twilio::TwiML::Response.new do |r|
        r.Message "Hey Monkey. Thanks for the message!"
      end
      render_twiml response
  end

end