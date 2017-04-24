class ColonyAntsController < ApplicationController
  before_action :set_colony_ant, only: [:show, :edit, :update, :destroy]

  # GET /colony_ants
  # GET /colony_ants.json
  def index
    @colony_ants = ColonyAnt.all
  end

  # GET /colony_ants/1
  # GET /colony_ants/1.json
  def show
  end

  # GET /colony_ants/new
  def new
    @colony_ant = ColonyAnt.new
  end

  # GET /colony_ants/1/edit
  def edit
  end

  # POST /colony_ants
  # POST /colony_ants.json
  def create
    @colony_ant = ColonyAnt.new(colony_ant_params)

    respond_to do |format|
      if @colony_ant.save
        format.html { redirect_to @colony_ant, notice: 'Colony ant was successfully created.' }
        format.json { render :show, status: :created, location: @colony_ant }
      else
        format.html { render :new }
        format.json { render json: @colony_ant.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /colony_ants/1
  # PATCH/PUT /colony_ants/1.json
  def update
    respond_to do |format|
      if @colony_ant.update(colony_ant_params)
        format.html { redirect_to @colony_ant, notice: 'Colony ant was successfully updated.' }
        format.json { render :show, status: :ok, location: @colony_ant }
      else
        format.html { render :edit }
        format.json { render json: @colony_ant.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /colony_ants/1
  # DELETE /colony_ants/1.json
  def destroy
    @colony_ant.destroy
    respond_to do |format|
      format.html { redirect_to colony_ants_url, notice: 'Colony ant was successfully destroyed.' }
      format.json { head :no_content }
    end
  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_colony_ant
      @colony_ant = ColonyAnt.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def colony_ant_params
      params.require(:colony_ant).permit(:set, :max_it, :num_ants, :decay, :c_heur, :c_local_phero, :c_greed)
    end
end
