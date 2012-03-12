class MoviesController < ApplicationController

    def show
        id = params[:id] # retrieve movie ID from URI route
        @movie = Movie.find(id) # look up movie by unique ID
        # will render app/views/movies/show.<extension> by default
    end

    def index
        if params[:order].nil? then
            params[:order] = session[:order].nil? ? "id" : session[:order]
        else
            session[:order] = params[:order]
        end

        if params[:ratings].nil? then
            params[:ratings] = session[:ratings].nil? ? {} : session[:ratings]
        else
            session[:ratings] = params[:ratings]
        end

        if params[:ratings].nil? then
            @movies = Movie.find(
                :all,
                :order => "#{params[:order]} ASC"
            )
        else
            @movies = Movie.find(
                :all,
                :conditions => { :rating => params[:ratings].keys },
                :order => "#{params[:order]} ASC"
            )
        end

        @all_ratings = Movie.ratings
    end

    def new
        # default: render 'new' template
    end

    def create
        @movie = Movie.create!(params[:movie])
        flash[:notice] = "#{@movie.title} was successfully created."
        redirect_to movies_path
    end

    def edit
        @movie = Movie.find params[:id]
    end

    def update
        @movie = Movie.find params[:id]
        @movie.update_attributes!(params[:movie])
        flash[:notice] = "#{@movie.title} was successfully updated."
        redirect_to movie_path(@movie)
    end

    def destroy
        @movie = Movie.find(params[:id])
        @movie.destroy
        flash[:notice] = "Movie '#{@movie.title}' deleted."
        redirect_to movies_path
    end

end
