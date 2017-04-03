class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :movies
  has_many :reviews

  has_many :movie_relationships
  has_many :favourite_movies, :through => :movie_relationships,
  :source => :movie

  def is_member_of?(movie)
    favourite_movies.include?(movie)
  end

  def favourite!(movie)
    favourite_movies << movie
  end

  def unfavourite!(movie)
    favourite_movies.delete(movie)
  end
  
end
