class LandmarksController < ApplicationController
  get '/landmarks' do
     @landmarks= Landmark.all
     erb :'/landmarks/index'
   end

  get '/landmarks/new' do
    erb :'landmarks/new'
  end

  post '/landmark' do
    @landmark = Landmark.create(params[:landmark])
    #binding.pry
    if !params[:figure][:name].empty?
     @landmark.figures << Figure.create(params[:figure])
   end
   if !params[:title][:name].empty?
     @landmark.titles << Title.create(params[:title])
   end
   @landmark.save
    redirect to "/landmarks/#{@landmark.id}"
  end

   get '/landmarks/:id' do
     @landmark = Landmark.find(params[:id])
     erb :'landmarks/show'
  end

  get '/landmarks/:id/edit' do
    @landmarks = Landmark.find_by(params[:id])
    erb :'landmarks/edit'
  end

  patch '/landmarks/:id' do
    landmark = Landmark.find_by(params[:id])
    landmark.update(params[:landmark])

    if !params[:figure][:name].empty?
     landmark.figures << Figure.create(params[:figure])
   end
   if !params[:title][:name].empty?
     landmark.titles << Title.create(params[:title])
   end
   landmark.save

    redirect to "/landmarks/#{landmark.id}"
  end
end
