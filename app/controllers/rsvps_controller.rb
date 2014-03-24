require 'mail'

class RsvpsController < ApplicationController
	def index
		@rsvps = Rsvp.all

		respond_to do |format|
			format.html
		end
	end

	def new
		@rsvp = Rsvp.new

	end

	def create
  		@rsvp = Rsvp.new(params[:rsvp].permit(:name, :check, :guest, :weekend, :email))
  		rsvp_email = @rsvp.email
  		@rsvp.save

		Mail.defaults do
  			delivery_method :smtp, { :address   => "secure.emailsrvr.com",
                           	:port      => 587,
                           	:domain    => "juanyitelina.com",
                           	:user_name => "juanyitelina@juanyitelina.com",
                           	:password  => "angrycoon89",
                           	:authentication => 'plain',
                           	:enable_starttls_auto => true }
		end

		mail = Mail.deliver do
  			to rsvp_email
  			from 'Juan + Itelina <juanyitelina@juanyitelina.com>'
  			subject 'Welcome to our wedding!'
  			text_part do
    			body 'Thank you for confirming to our wedding!!'
  			end
  			html_part do
    			content_type 'text/html; charset=UTF-8'
    			body 'Thank you for confirming to our wedding!!'
  			end
		end

  		redirect_to :action=>'index'

	end

	def destroy
		@rsvp = Rsvp.find(params[:id])
		@rsvp.destroy

    	respond_to do |format|
      		format.html { redirect_to :action=>'index' }
    	end
  	end

end
