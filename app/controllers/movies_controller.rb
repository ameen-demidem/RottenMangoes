class MoviesController < ApplicationController

  before_action :check_authentication, except: [:index, :show]

  def index
    @movies = Movie.all
  end

  def create
    @movie = Movie.new(movie_params)
    if @movie.save
      redirect_to movies_path, notice: "New movie successfully added."
    else
      flash.now.alert = "Couldn't create the new movie!"
      render :new
    end
  end

  def new
    @movie = Movie.new
  end

  def edit
    @movie = Movie.find_by(id: params[:id])
    redirect_to movies_path, alert: "Could not find the movie to update!" unless @movie
  end

  def show
    @movie = Movie.find_by(id: params[:id])
    if !@movie
      alert_msg = "No such movie (id: #{params[:id]}) to display!"
      redirect_to movies_path, alert: alert_msg unless @movie
    end
  end

  def update
    @movie = Movie.find_by(id: params[:id])
    if !@movie
      alert_msg = "No such movie (id: #{params[:id]}) to edit!"
      redirect_to movies_path, alert: alert_msg unless @movie
      return
    end

    if @movie.update_attributes(movie_params)
      redirect_to movie_path(@movie), notice: "Successfully updated the movie posting."
    else
      redirect_to edit_movie_path(@movie), alert: "Couldn't update the movie!"
    end
  end

  def destroy
    @movie = Movie.find_by(id: params[:id])
    if !@movie
      alert_msg = "No such movie (id: #{params[:id]}) to delete!"
      redirect_to movies_path, alert: alert_msg unless @movie
      return
    end
    
    @movie.destroy
    redirect_to movies_path, notice: "Successfully deleted the movie posting"
  end

  private

  def movie_params
    params.require(:movie).permit(
      :title, :director, :runtime_in_minutes, :description,
      :poster_image_url, :release_date
    )
  end
end
