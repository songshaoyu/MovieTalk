class MoviesController < ApplicationController
  before_action :authenticate_user!, only:[:new,:edit,:destroy,:update]
  before_action :find_movie_and_check_permission, only: [:edit,:update,:destroy]
  def index
    @movies = Movie.all
  end

  def show
    @movie = Movie.find(params[:id])
    @reviews = @movie.reviews
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.new(movie_params)
    @movie.user = current_user
    if @movie.save
      redirect_to movies_path
    else
      render :new
    end
  end

  def destrpy

    @movie.destroy
    redirect_to movies_path
  end

  def edit

  end

  def update

    if @movie.update(movie_params)
      flash[:notice] = "update success"
      redirect_to movies_path
    else
      render :edit
    end
  end

  private

  def find_movie_and_check_permission
    @movie = Movie.find(params[:id])
    if current_user != @movie.user
       redirect_to root_path, alert: "You have no permission."
    end
  end

  def movie_params
    params.require(:movie).permit(:title, :description)
  end

end
