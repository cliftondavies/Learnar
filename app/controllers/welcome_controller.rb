class WelcomeController < ApplicationController
  def index
    redirect_to progress_updates_path if signed_in?
  end
end
