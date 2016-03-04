class MoviesController < ApplicationController
  def index

    # Enhancement 5: search
    title = params[:title] unless params[:title] == ""
    director = params[:director] unless params[:director] == ""
    runtime = params[:runtime] unless params[:runtime] == ""

    if title || director || runtime
      @movies = []
      @movies << Movie.where("title like ?", "%#{title}%") if title
      @movies << Movie.where("director like ?", "%#{director}%") if director
      case runtime
      when "Under 90 minutes"
        @movies << Movie.where("runtime_in_minutes < ?", 90) 
      when "Between 90 and 120 minutes"
        @movies << Movie.where("runtime_in_minutes BETWEEN ? AND ?", 90, 120) 
      when "Over 120 minutes"
        @movies << Movie.where("runtime_in_minutes > ?", 120) 
      end
      @movies.flatten!
    else # show all movie if no input to the search
      @movies = Movie.all
    end
  end

  def show
    @movie = Movie.find(params[:id])
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.new(movie_params)

    if @movie.save
      redirect_to movies_path, notice: "#{@movie.title} was submitted successfully!"
    else
      render :new
    end
  end

  def edit
    @movie = Movie.find(params[:id])
  end

  def create
    @movie = Movie.new(movie_params)

    if @movie.save
      redirect_to movies_path
    else
      render :new
    end
  end

  def update
    @movie = Movie.find(params[:id])

    if @movie.update_attributes(movie_params)
      redirect_to movie_path(@movie)
    else
      render :edit
    end
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    redirect_to movies_path
  end

  protected

  def movie_params
    params.require(:movie).permit(
      :title, :release_date, :director, :runtime_in_minutes, :poster_image_url, :description, :image
    )
  end
end
