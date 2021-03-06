class StoriesController < ApplicationController

  before_filter :authenticate_user!, except: [:show]

  # GET /stories
  # GET /stories.json

  def index
    @stories = current_user.stories.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @stories }
    end
  end

  # GET /stories/1
  # GET /stories/1.json
  def show
    @story = Story.find params[:id]

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @story }
    end
  end

  # GET /stories/new
  # GET /stories/new.json
  def new
    @story = current_user.stories.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @story }
    end
  end

  # GET /stories/1/edit
  def edit
    @story = current_user.stories.find(params[:id])
  end

  # POST /stories
  # POST /stories.json
  def create
    @story = current_user.stories.new(params[:story])

    respond_to do |format|
      if @story.save
        format.html { redirect_to @story, flash: { success: 'Story was successfully created!' }}
        format.json { render json: @story, status: :created, location: @story }
      else
        flash[:error] = 'Story was not successfully created!'
        format.html { render action: "new" }
        format.json { render json: @story.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /stories/1
  # PUT /stories/1.json
  def update
    @story = current_user.stories.find(params[:id])

    respond_to do |format|
      if @story.update_attributes(params[:story])
        format.html { redirect_to @story }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @story.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stories/1
  # DELETE /stories/1.json
  def destroy
    @story = current_user.stories.find(params[:id])
    @story.destroy

    respond_to do |format|
      format.html { redirect_to stories_url }
      format.json { head :no_content }
    end
  end

end
