require 'twilio-ruby'

class TextResponseController < ApplicationController

  def respond
      response = Twilio::TwiML::Response.new do |r|
        r.Message "Hey Monkey. Thanks for the message!"
      end
      twiml.text
  end

end