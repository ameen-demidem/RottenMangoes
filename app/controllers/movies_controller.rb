class MoviesController < ApplicationController
  def index
    @movies = Movie.all
  end

  def create
    @movie = Movie.new(movie_params)
    if @movie.save
      redirect_to movies_path
    else
      flash[:error] = "Couldn't create the new movie!"
      redirect_to new_movie_path
    end
  end

  def new
    @movie = Movie.new
  end

  def edit
    @movie = Movie.find_by(id: params[:id])
    redirect_to movies_path unless @movie
  end

  def show
    @movie = Movie.find_by(id: params[:id])
    redirect_to movies_path unless @movie
  end

  def update
    @movie = Movie.find_by(id: params[:id])
    redirect_to movies_path unless @movie

    redirect_to movie_path(@movie) if @movie.update_attributes(movie_params)
    flash[:error] = "Couldn't update the movie!"
  end

  def destroy
    @movie = Movie.find_by(id: params[:id])
    redirect_to movies_path unless @movie
    
    @movie.destroy
    redirect_to movies_path
  end

  private

  def movie_params
    params.require(:movie).permit(
      :title, :director, :runtime_in_minutes, :description,
      :poster_image_url, :release_date
    )
  end
end
