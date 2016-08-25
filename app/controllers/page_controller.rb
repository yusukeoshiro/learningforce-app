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
		history = payload["history"]


		if !event["From1__c"].nil? && event["To1__c"]
			cal = Icalendar::Calendar.new

			cal.timezone do |t|
			  t.tzid = "Etc/UTC"
			  t.standard do |s|
			    s.tzoffsetfrom = "-0000"
			    s.tzoffsetto   = "-0000"
			    s.tzname       = "UTC"
			  end
			end


			cal.event do |e|
				p event["From1__c"]
				p Time.parse( event["From1__c"] ).to_datetime
				e.dtstart     = Time.zone.parse( event["From1__c"] )
				e.dtend       = Time.zone.parse( event["To1__c"] )
				e.summary     = event["Name"]
				e.description = event["Description__c"]
				e.ip_class    = "PUBLIC"
				e.status      = "CONFIRMED"
				e.sequence    = 0
				e.priority    = 5
				e.transp      = "OPAQUE"
				e.uid         = event["Id"]+"."+user["Email"]+".1" #first event
				e.attendee = Icalendar::Values::CalAddress.new("mailto:"+user["Email"], cn: user["Name"])
				e.location = event["location__c"]
			end
			cal.ip_method = "REQUEST"
			p cal.to_ical

			EventInvitation.new_event(user["Email"], cal.to_ical , event["Name"] ).deliver_now
		end




		if !event["From2__c"].nil? && event["To2__c"]
			cal = Icalendar::Calendar.new

			cal.timezone do |t|
			  t.tzid = "Etc/UTC"
			  t.standard do |s|
			    s.tzoffsetfrom = "-0000"
			    s.tzoffsetto   = "-0000"
			    s.tzname       = "UTC"
			  end
			end


			cal.event do |e|
				e.dtstart     = Time.zone.parse( event["From2__c"] )
				e.dtend       = Time.zone.parse( event["To2__c"] )
				e.summary     = event["Name"]
				e.description = event["Description__c"]
				e.ip_class    = "PUBLIC"
				e.status      = "CONFIRMED"
				e.sequence    = 0
				e.priority    = 5
				e.transp      = "OPAQUE"
				e.uid         = event["Id"]+"."+user["Email"]+".2" # second event
				e.attendee = Icalendar::Values::CalAddress.new("mailto:"+user["Email"], cn: user["Name"])
				e.location = event["location__c"]
			end
			cal.ip_method = "REQUEST"
			p cal.to_ical

			EventInvitation.new_event(user["Email"], cal.to_ical , event["Name"] ).deliver_now
		end


		if !event["From3__c"].nil? && event["To3__c"]
			cal = Icalendar::Calendar.new

			cal.timezone do |t|
			  t.tzid = "Etc/UTC"
			  t.standard do |s|
			    s.tzoffsetfrom = "-0000"
			    s.tzoffsetto   = "-0000"
			    s.tzname       = "UTC"
			  end
			end


			cal.event do |e|
				e.dtstart     = Time.zone.parse( event["From3__c"] )
				e.dtend       = Time.zone.parse( event["To3__c"] )
				e.summary     = event["Name"]
				e.description = event["Description__c"]
				e.ip_class    = "PUBLIC"
				e.status      = "CONFIRMED"
				e.sequence    = 0
				e.priority    = 5
				e.transp      = "OPAQUE"
				e.uid         = event["Id"]+"."+user["Email"]+".3" #third event
				e.attendee = Icalendar::Values::CalAddress.new("mailto:"+user["Email"], cn: user["Name"])
				e.location = event["location__c"]
			end
			cal.ip_method = "REQUEST"
			p cal.to_ical

			EventInvitation.new_event(user["Email"], cal.to_ical , event["Name"] ).deliver_now
		end


		render :json => nil
	end
end
