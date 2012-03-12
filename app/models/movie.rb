class Movie < ActiveRecord::Base
    def Movie.ratings
        movies = Movie.select(:rating).uniq.map {|r| r.rating}
        movies.uniq.sort
    end
end
