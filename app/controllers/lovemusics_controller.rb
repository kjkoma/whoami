class LovemusicsController < ApplicationController
  before_action :set_lovemusic, only: [:show, :edit, :update, :destroy]

           def home
             @profile = Profile.first
             @lovemusic = Lovemusic.first

           end
  # GET /lovemusics
  # GET /lovemusics.json
  def index
    @lovemusics = Lovemusic.all
  end

  # GET /lovemusics/1
  # GET /lovemusics/1.json
  def show
  end

  # GET /lovemusics/new
  def new
    @lovemusic = Lovemusic.new
  end

  # GET /lovemusics/1/edit
  def edit
  end

  # POST /lovemusics
  # POST /lovemusics.json
  def create
    @lovemusic = Lovemusic.new(lovemusic_params)

    respond_to do |format|
      if @lovemusic.save
        format.html { redirect_to @lovemusic, notice: 'Lovemusic was successfully created.' }
        format.json { render :show, status: :created, location: @lovemusic }
      else
        format.html { render :new }
        format.json { render json: @lovemusic.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lovemusics/1
  # PATCH/PUT /lovemusics/1.json
  def update
    respond_to do |format|
      if @lovemusic.update(lovemusic_params)
        format.html { redirect_to @lovemusic, notice: 'Lovemusic was successfully updated.' }
        format.json { render :show, status: :ok, location: @lovemusic }
      else
        format.html { render :edit }
        format.json { render json: @lovemusic.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lovemusics/1
  # DELETE /lovemusics/1.json
  def destroy
    @lovemusic.destroy
    respond_to do |format|
      format.html { redirect_to lovemusics_url, notice: 'Lovemusic was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lovemusic
      @lovemusic = Lovemusic.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def lovemusic_params
      params.require(:lovemusic).permit(:loveword)
    end
end
