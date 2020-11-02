class InventoryItemsController < ApplicationController
  before_action :set_inventory_item, only: [:show, :edit, :update, :destroy]
  before_action :require_bunker_id, only: [:new]
  # GET /inventory_items
  # GET /inventory_items.json
  def index
    @inventory_items = InventoryItem.all
  end

  # GET /inventory_items/1
  # GET /inventory_items/1.json
  def show
  end

  # GET /inventory_items/new
  def new
    @inventory_item = InventoryItem.new
    @bunker = Bunker.find_by!(id: params[:bunker_id])
    @inventory_item.bunker = @bunker
  end

  # GET /inventory_items/1/edit
  def edit
  end

  # POST /inventory_items
  # POST /inventory_items.json
  def create
    @inventory_item = InventoryItem.new(create_inventory_item_params)
    puts params
    respond_to do |format|
      if @inventory_item.save
        format.html { redirect_to @inventory_item, notice: 'Inventory item was successfully created.' }
        format.json { render :show, status: :created, location: @inventory_item }
      else
        format.html { render :new }
        format.json { render json: @inventory_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /inventory_items/1
  # PATCH/PUT /inventory_items/1.json
  def update
    respond_to do |format|
      if @inventory_item.update(update_inventory_item_params)
        format.html { redirect_to @inventory_item, notice: 'Inventory item was successfully updated.' }
        format.json { render :show, status: :ok, location: @inventory_item }
      else
        format.html { render :edit }
        format.json { render json: @inventory_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /inventory_items/1
  # DELETE /inventory_items/1.json
  def destroy
    @inventory_item.destroy
    respond_to do |format|
      format.html { redirect_to inventory_items_url, notice: 'Inventory item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_inventory_item
      @inventory_item = InventoryItem.find(params[:id])
    end

    def require_bunker_id
      unless params.has_key?(:bunker_id)
        redirect_to inventory_items_url, alert: 'You need to set a bunker to create an item'
      end
    end

    # Only allow a list of trusted parameters through.
    def create_inventory_item_params
      params.require(:inventory_item).permit(:food_type, :exp_date, :quantity, :nutrition_per_unit, :bunker_id)
    end

    def update_inventory_item_params
      params.require(:inventory_item).permit(:food_type, :exp_date, :quantity, :nutrition_per_unit)
    end

end
