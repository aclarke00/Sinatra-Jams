require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

    #root route
  get "/" do
    erb :welcome
  end

  #class route
  get "/artists" do
    @artists = Artist.all
    erb :index
  end

  #new instance
  get "/artists/new" do
    erb :new_form
  end

  #
  post "/artists" do
    @artist = Artist.create(params)
    redirect to "/artists/#{@artist.id}"
    #Artist.create(params[:name], params[:age], params[:bio])
  end

  get "/artists/:id" do
    @artist = Artist.find(params[:id])
    erb :show
  end

  get "/artists/:id/edit" do
    @artist = Artist.find(params[:id])
    erb :update_form
  end

  patch "/artists/:id" do
    @artist = Artist.find(params[:id])
    params.delete(:"_method")
    @artist.update(params)
    redirect to "/artists/#{@artist.id}"
  end

  delete "/artists/:id" do
    @artist = Artist.find(params[:id])
    @artist.destroy
    redirect to "/artists"
  end

end#end class
