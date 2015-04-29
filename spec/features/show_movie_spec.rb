require 'spec_helper'

describe "Viewing an individual movie" do
  it "shows the movie's details" do
    movie = Movie.create(movie_attributes)

    visit movie_url(movie)

    expect(page).to have_text(movie.title)
    expect(page).to have_text(movie.rating)
    expect(page).to have_text(movie.description)
    expect(page).to have_text(movie.released_on)
    expect(page).to have_text(movie.cast)
    expect(page).to have_text(movie.director)
    expect(page).to have_text(movie.duration)
    expect(page).to have_selector("img[src$='#{movie.image_file_name}']")
  end  
  
  it "shows the total gross if the total gross exceeds $50M" do
    movie = Movie.create(movie_attributes(total_gross: 60000000))

    visit movie_url(movie)

    expect(page).to have_text("$60,000,000.00")
  end

  it "shows 'Flop!' if the total gross is less than $50M" do
    movie = Movie.create(movie_attributes(total_gross: 40000000))

    visit movie_url(movie)

    expect(page).to have_text("Flop!")
  end
  
  it "does not show 'Flop!' if the total_gross is less than $50m as long as reviews.count > 4 and an average_stars >= 4" do
    movie = Movie.create(movie_attributes(total_gross: 40000000))
    review1 = movie.reviews.create(review_attributes(stars: 4))
    review2 = movie.reviews.create(review_attributes(stars: 4))
    review3 = movie.reviews.create(review_attributes(stars: 4))
    review4 = movie.reviews.create(review_attributes(stars: 4))
    review5 = movie.reviews.create(review_attributes(stars: 4))

    visit movie_url(movie)

    expect(page).to_not have_text("Flop!")
  end
end