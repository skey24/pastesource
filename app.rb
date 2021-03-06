#!/usr/bin/env ruby

require 'sinatra'
require 'mongoid'

configure do
  Mongoid.load!("./mongoid.yml")
end

class Paste
  include Mongoid::Document
  field :paste, type: String
  field :title,   type: String
  field :text,   type: String
  field :syntax,   type: String
  field :private, type: Boolean
end


get '/' do
  # form for enter code
  erb :post, :layout => :layout
end

get '/all' do
    @paste = Paste.all.where(private: nil).desc('_id').limit(200)
    erb :show_all
end

get '/:id' do
  #show paste
  @paste = Paste.find_by(paste: params[:id])
  text = @paste.text
  syntax = @paste.syntax
  
    erb :show_paste, :locals => {:paste => text, :syntax => syntax}, :layout => :layout
end

post '/paste' do
  #generating address 
  @paste_id = (('a'..'z').to_a+('A'..'Z').to_a+(0..9).to_a).shuffle[0,8].join
  @title = params[:title]
  @text = params[:text]
  @private = params[:private]
  paste = Paste.new
  paste.paste = @paste_id
  if @title == ""
    paste.title = "Untitled"
  else
    paste.title = @title
  end
  paste.syntax = params[:syntax]
  paste.text = @text
  paste.private = @private
  paste.save
  
  redirect "/#{@paste_id}"
end


helpers do
  def raw(text)
    Rack::Utils.escape_html(text)
  end
end


