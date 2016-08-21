require "pp"
require 'icalendar'
require 'time'


class PageController < ApplicationController
	skip_before_filter :verify_authenticity_token

	
	def send_invite

		# get the payload 
		payload = JSON.parse(params["payload"])
		event = payload["training"]
		user = payload["targetUser"]

		cal = Icalendar::Calendar.new
		cal.event do |e|
			p event["From1__c"]
			p Time.parse( event["From1__c"] ).to_datetime
			e.dtstart     = Time.parse( event["From1__c"] ).to_datetime
			e.dtend       = Time.parse( event["To1__c"] ).to_datetime
			e.summary     = event["Name"]
			e.description = event["Description__c"]
			e.ip_class    = "PUBLIC"
			e.status      = "CONFIRMED"
			e.sequence    = 0
			e.priority    = 5
			e.transp      = "OPAQUE"
			e.attendee = Icalendar::Values::CalAddress.new("mailto:"+user["Email"], cn: user["Name"])
		end

		#cal.publish
		cal.ip_method = "REQUEST"
		EventInvitation.new_event(user["Email"], cal.to_ical , event["Name"] ).deliver_now
		render :json => nil
	end
end
