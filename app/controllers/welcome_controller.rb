class WelcomeController < ApplicationController

  def index
    @stories = Story.all
  end

end
