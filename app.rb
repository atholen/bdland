# app.rb

require 'rubygems'
require 'sinatra'
require 'haml'
require 'sass'
require 'coffee-script'


################################# CONFIG #################################


# configure do
#   set :name, ENV['NAME'] || 'NEOSORA'
#   set :author, ENV['AUTHOR'] || 'Neo Sora'
#   # set :analytics, ENV['ANALYTICS'] || 'UA-XXXXXXXX-X'
#   set :javascripts, %w[ ]
#   set :fonts, %w[ Noto ]
#   # set :markdown, :layout_engine => :slim
# end

# set sinatra's variables
set :app_file, __FILE__
set :root, File.dirname(__FILE__)
set :views, "views"
set :public_dir, 'static'


################################# ROUTING #################################

projects = [ "ryuichisakamoto", "yoshitakaamano", "ericclapton", "lostintranslation", "marcjacobs" ]

get "/:name.css" do
  content_type 'text/css', :charset => 'utf-8'
  sass "stylesheets/#{ params[ :name ] }".to_sym
end

get "/:name.js" do
  coffee "javascripts/#{ params[ :name ] }".to_sym
end

get '/' do
  @video_number = rand( 7 )
  haml :index
end

get '/:project' do
  @page = params[:project]

  if projects.include? @page
    haml :projects, layout: :projects_layout
  else
    haml :'404', layout: :projects_layout
  end
end

get '/jp/' do
  @video_number = rand( 6 )
  @jp = true
  
  haml :'jp/index'
end

get '/jp/:project' do
  @jp = true
  @page = params[:project]

  if projects.include? @page
    haml :projects, layout: :projects_layout
  else
    haml :'404', layout: :projects_layout
  end
end

not_found { haml :'404' }
error { haml :'500' }

__END__

@@404
.error-page
  %h3 404
  %p It seems this page is missing...

@@505
.error-page
  %h3 505 Error
  %p Something's gone wrong...