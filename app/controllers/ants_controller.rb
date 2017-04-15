class AntsController < ApplicationController
  before_action :set_ant, only: [:show, :edit, :update, :destroy]

  # GET /ants
  # GET /ants.json
  def index
    @ants = Ant.all
  end

  # GET /ants/1
  # GET /ants/1.json
  def show
  end

  # GET /ants/new
  def new
    @ant = Ant.new
  end

  # GET /ants/1/edit
  def edit
  end

  # POST /ants
  # POST /ants.json
  def create
    @ant = Ant.new(ant_params)

    respond_to do |format|
      if @ant.save
        format.html { redirect_to @ant, notice: 'Ant was successfully created.' }
        format.json { render :show, status: :created, location: @ant }
      else
        format.html { render :new }
        format.json { render json: @ant.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ants/1
  # PATCH/PUT /ants/1.json
  def update
    respond_to do |format|
      if @ant.update(ant_params)
        format.html { redirect_to @ant, notice: 'Ant was successfully updated.' }
        format.json { render :show, status: :ok, location: @ant }
      else
        format.html { render :edit }
        format.json { render json: @ant.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ants/1
  # DELETE /ants/1.json
  def destroy
    @ant.destroy
    respond_to do |format|
      format.html { redirect_to ants_url, notice: 'Ant was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ant
      @ant = Ant.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ant_params
      params.require(:ant).permit(:set, :max_it, :num_ants, :decay_factor, :c_heur, :c_hist)
    end
end
