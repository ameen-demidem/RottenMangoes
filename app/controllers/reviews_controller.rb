class ReviewsController < ApplicationController

  before_action :check_authentication
  before_action :load_movie

  def new
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    @review.user = current_user
    @review.movie = @movie

    if @review.save
      redirect_to @movie, notice: "Review added successfully."
    else
      flash.now.alert = "Couldn't create a review for the movie"
      render :new
    end
  end

  protected

  def review_params
    params.require(:review).permit(:text, :rating_out_of_ten)
  end

  def load_movie
    @movie = Movie.find_by(id: params[:movie_id])
    if !@movie
      flash.alert = "Can find movie #{params[:movie_id]}!"
      redirect_to movies_path
      return
    end
  end
end
