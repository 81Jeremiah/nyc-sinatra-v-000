class FiguresController < ApplicationController

  get '/figures' do
     @figures = Figure.all
     erb :'/figures/index'
   end

  get '/figures/new' do
    erb :'figures/new'
  end

  post '/figures' do
    @figure = Figure.create(params[:figure])
    #binding.pry
    if !params[:landmark][:name].empty?
     @figure.landmarks << Landmark.create(params[:landmark])
   end
   if !params[:title][:name].empty?
     @figure.titles << Title.create(params[:title])
   end
   @figure.save
    redirect to "/figures/#{@figure.id}"
  end

   get '/figures/:id' do
     @figure = Figure.find(params[:id])
     erb :'figures/show'
  end

  get '/figures/:id/edit' do
    @figure = Figure.find_by(params[:id])
    erb :'figures/edit'
  end

  patch '/figures/:id' do
    figure = Figure.find_by(params[:id])
    
    if !params[:landmark][:name].empty?
     figure.landmarks << Landmark.create(params[:landmark])
   end
   if !params[:title][:name].empty?
     figure.titles << Title.create(params[:title])
   end
   figure.update(params[:figure])

    redirect to "/figures/#{figure.id}"
  end
end
