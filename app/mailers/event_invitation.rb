class EventInvitation < ApplicationMailer
	default from: "learningforce@salesforce.com"

	def new_event( email, ics_content, event_name )
	    #attachments['invite.ics'] = File.read('invite.ics')
	    mail(to: email, subject: 'トレーニング招待: ' + event_name)
	end

end
