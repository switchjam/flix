class ReviewsController < ApplicationController

  before_action :set_movie
  
  def index
    @reviews = @movie.reviews
  end
  
  def show
    @review = @movie.reviews.find(params[:id])
  end
  
  def new
    @review = @movie.reviews.new
  end
  
  def create
    @review = @movie.reviews.new(review_params)
    if @review.save
      redirect_to movie_reviews_path(@movie), notice: "Thanks for your review!"
    else
      render :new
    end
  end
  
  def review_params
    params.require(:review).permit(:name, :stars, :comment)
  end
  
  def destroy
    @movie.reviews.find(params[:id]).destroy
    redirect_to movie_reviews_url(@movie), alert: "Review successfully deleted!"
  end
  
  def edit
    @review = @movie.reviews.find(params[:id])
  end
  
  def update
    @review = @movie.reviews.find(params[:id])
    if @review.update(review_params)
      # flash[:notice] = 'Movie successfully updated!'
      redirect_to movie_reviews_path, notice: "Review successfully updated!"
    else
      render :edit
    end
  end

  private

  def set_movie
    @movie = Movie.find(params[:movie_id])
  end
  
end