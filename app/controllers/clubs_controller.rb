class ClubsController < ApplicationController
  def index
    @players = Player.all
  end
end
