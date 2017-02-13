class ClubsController < ApplicationController
  def index
    if params["name"]
      @players = Club.find_by(name:params["name"]).players
      render json: @players
    else
      render 'landings/index'
    end
  end
end
