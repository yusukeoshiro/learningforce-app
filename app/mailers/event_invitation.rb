class EventInvitation < ApplicationMailer
	default from: "no-reply@learningforce.com"

	def new_event( email, ics_content, event_name )
	    attachments['invite.ics'] = ics_content
	    mail(to: email, subject: 'トレーニング招待: ' + event_name)
	end
end
