class MoviesController < ApplicationController
  def index

    # Enhancement 5: search
    title = params[:title] unless params[:title] == ""
    director = params[:director] unless params[:director] == ""
    runtime = params[:runtime] unless params[:runtime] == ""

    if title || director || runtime
      @movies = []
      @movies << Movie.search_title(title) if title
      @movies << Movie.search_director(director) if director
      @movies << Movie.search_runtime(runtime) if runtime
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
