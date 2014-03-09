#!/usr/bin/env ruby

require 'sinatra'
require 'mongoid'

configure do
  Mongoid.load!("./mongoid.yml")
end

class Paste
  include Mongoid::Document
  field :id, type: String
  field :title,   type: String
  field :text,   type: String
  field :private, type: Boolean
end


get '/' do
  # form for enter code
  erb :post, :layout => :layout
end

get '/:id' do
  #show paste
  @paste = Paste.find(params[:id])
  @text = @paste.text
  
end

post '/paste' do
  #generating address 
  @paste_id = (('a'..'z').to_a+('A'..'Z').to_a+(0..9).to_a).shuffle[0,8].join
  @title = params[:title]
  @text = params[:text]
  @private = params[:private]
  paste = Paste.new
  paste.id = @paste_id
  paste.title = @title
  paste.text = @text
  paste.private = @private
  paste.save
  
  redirect "/#{@paste_id}"
end

get '/all' do

  
end
