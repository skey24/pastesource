#!/usr/bin/env ruby

require 'sinatra'

get '/' do
  # form for enter code
end

get '/:paste' do
  #show paste
end

post '/paste' do
  #generating address 
  addr = (('a'..'z').to_a+('A'..'Z').to_a+(0..9).to_a).shuffle[0,8].join
  
  @text = params[:text]
  
end
