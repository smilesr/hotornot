class TextResponseController < ApplicationController

  def respond
      twiml = Twilio::TwiML::Response.new do |r|
        r.Message "Hey Monkey. Thanks for the message!"
      end
      render_twiml response
  end

end