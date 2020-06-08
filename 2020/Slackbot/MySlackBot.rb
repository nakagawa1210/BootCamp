$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'sinatra'
require 'SlackBot'

class MySlackBot < SlackBot
  # cool code goes here
end

slackbot = MySlackBot.new

set :environment, :production

get '/' do
  "SlackBot Server"
end

post '/slack' do
  content_type :json
  send_text = params[:text].split(/「|」/)

  if send_text[2] == "と言って" then
    slackbot.post_message(send_text[1],username: "nakagawa_inbot")
  elsif send_text[1] == "password" then
    post_msg = slackbot.password
    slackbot.post_message(post_msg,username: "nakagawa_inbot")
  else
    slackbot.naive_respond(params,username: "nakagawa_inbot")
  end
end