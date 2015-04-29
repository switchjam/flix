require 'spec_helper'

describe "Deleting a review" do 
  it "destroys the review and shows the review listing without the deleted review" do
    movie = Movie.create(movie_attributes)
    review1 = movie.reviews.create(review_attributes)

    visit movie_reviews_path(movie, review1)
    
    click_link 'Delete'
    
    expect(current_path).to eq(movie_reviews_path(movie))
    expect(page).to have_text('Review successfully deleted!')
  end
end