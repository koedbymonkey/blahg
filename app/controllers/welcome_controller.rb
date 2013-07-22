class WelcomeController < ApplicationController

  def index
    @stories = Story.order 'created_at DESC'
  end

end
