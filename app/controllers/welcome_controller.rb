class WelcomeController < ApplicationController
  def index
    flash[:notice] = "test success"
  end
end
