class MoviesController < ApplicationController
  before_action :authenticate_user!, only:[:new,:edit,:destroy,:update, :favourie, :unfavourite]
  before_action :find_movie_and_check_permission, only: [:edit,:update,:destroy]
  def index
    @movies = Movie.all
  end

  def show
    @movie = Movie.find(params[:id])
    @reviews = @movie.reviews.recent.paginate(:page => params[:page], :per_page => 6)
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.new(movie_params)
    @movie.user = current_user
    if @movie.save
      current_user.favourite!(@movie)
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

  def favourite
    @movie = Movie.find(params[:id])

    if !current_user.is_member_of?(@movie)
      current_user.favourite!(@movie)
      flash[:notice] = "收藏本电影成功"
    else
      flash[:warning] = "你已经收藏，xd"
    end
    redirect_to movie_path(@movie)
  end

  def unfavourite
    @movie = Movie.find(params[:id])

    if current_user.is_member_of?(@movie)
      current_user.unfavourite!(@movie)
      flash[:alert] = "未收藏"
    else
      flash[:warning] = "你还没收藏，怎么放弃收藏"
    end
    redirect_to movie_path(@movie)
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
