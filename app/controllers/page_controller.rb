class PageController < ApplicationController
  def send_invite
  	EventInvitation.new_event("yusuke@oshiro1.com", "aa","new event!").deliver_now
  	render :json => nil
  end
end
