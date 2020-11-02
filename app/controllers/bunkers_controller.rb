class BunkersController < ApplicationController
  before_action :set_bunker, only: [:show, :edit, :update, :destroy]

  # GET /bunkers
  # GET /bunkers.json
  def index
    @bunkers = Bunker.all
  end

  # GET /bunkers/1
  # GET /bunkers/1.json
  def show
  end

  # GET /bunkers/new
  def new
    @bunker = Bunker.new
  end

  # GET /bunkers/1/edit
  def edit
  end

  # POST /bunkers
  # POST /bunkers.json
  def create
    @bunker = Bunker.new(bunker_params)

    respond_to do |format|
      if @bunker.save
        format.html { redirect_to @bunker, notice: 'Bunker was successfully created.' }
        format.json { render :show, status: :created, location: @bunker }
      else
        format.html { render :new }
        format.json { render json: @bunker.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bunkers/1
  # PATCH/PUT /bunkers/1.json
  def update
    respond_to do |format|
      if @bunker.update(bunker_params)
        format.html { redirect_to @bunker, notice: 'Bunker was successfully updated.' }
        format.json { render :show, status: :ok, location: @bunker }
      else
        format.html { render :edit }
        format.json { render json: @bunker.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bunkers/1
  # DELETE /bunkers/1.json
  def destroy
    @bunker.destroy
    respond_to do |format|
      format.html { redirect_to bunkers_url, notice: 'Bunker was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_bunker
    @bunker = Bunker.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def bunker_params
    params.require(:bunker).permit(:name, :address, :capacity)
  end
end
