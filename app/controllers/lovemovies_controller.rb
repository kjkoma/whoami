class LovemoviesController < ApplicationController
  before_action :set_lovemovie, only: [:show, :edit, :update, :destroy]

 def home
             @profile = Profile.first
             @lovemovie = Lovemovie.first
           end


  # GET /lovemovies
  # GET /lovemovies.json
  def index
    @lovemovies = Lovemovie.all
  end

  # GET /lovemovies/1
  # GET /lovemovies/1.json
  def show
  end

  # GET /lovemovies/new
  def new
    @lovemovie = Lovemovie.new
  end

  # GET /lovemovies/1/edit
  def edit
  end

  # POST /lovemovies
  # POST /lovemovies.json
  def create
    @lovemovie = Lovemovie.new(lovemovie_params)

    respond_to do |format|
      if @lovemovie.save
        format.html { redirect_to @lovemovie, notice: 'Lovemovie was successfully created.' }
        format.json { render :show, status: :created, location: @lovemovie }
      else
        format.html { render :new }
        format.json { render json: @lovemovie.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lovemovies/1
  # PATCH/PUT /lovemovies/1.json
  def update
    respond_to do |format|
      if @lovemovie.update(lovemovie_params)
        format.html { redirect_to @lovemovie, notice: 'Lovemovie was successfully updated.' }
        format.json { render :show, status: :ok, location: @lovemovie }
      else
        format.html { render :edit }
        format.json { render json: @lovemovie.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lovemovies/1
  # DELETE /lovemovies/1.json
  def destroy
    @lovemovie.destroy
    respond_to do |format|
      format.html { redirect_to lovemovies_url, notice: 'Lovemovie was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lovemovie
      @lovemovie = Lovemovie.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def lovemovie_params
      params.require(:lovemovie).permit(:loveword)
    end
end
