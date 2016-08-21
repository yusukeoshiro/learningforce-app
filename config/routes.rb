Rails.application.routes.draw do
  get 'page/send_invite'

  get '/invite', :to => 'page#send_invite'
  post '/invite', :to => 'page#send_invite'

 
end
