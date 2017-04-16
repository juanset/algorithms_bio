class BeesController < ApplicationController
  before_action :set_bee, only: [:show, :edit, :update, :destroy]

  # GET /bees
  # GET /bees.json
  def index
    @bees = Bee.all
  end

  # GET /bees/1
  # GET /bees/1.json
  def show
  end

  # GET /bees/new
  def new
    @bee = Bee.new
  end

  # GET /bees/1/edit
  def edit
  end

  # POST /bees
  # POST /bees.json
  def create
    @bee = Bee.new(bee_params)

    respond_to do |format|
      if @bee.save
        format.html { redirect_to @bee, notice: 'Bee was successfully created.' }
        format.json { render :show, status: :created, location: @bee }
      else
        format.html { render :new }
        format.json { render json: @bee.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bees/1
  # PATCH/PUT /bees/1.json
  def update
    respond_to do |format|
      if @bee.update(bee_params)
        format.html { redirect_to @bee, notice: 'Bee was successfully updated.' }
        format.json { render :show, status: :ok, location: @bee }
      else
        format.html { render :edit }
        format.json { render json: @bee.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bees/1
  # DELETE /bees/1.json
  def destroy
    @bee.destroy
    respond_to do |format|
      format.html { redirect_to bees_url, notice: 'Bee was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # algoritmo de abejas
  def algorithm()
    @bee = Bee.find(params[:id])
    problem_size = @bee.problem_size
    search_space = Array.new(problem_size) {|i| [-5, 5]}
    @best = search(@bee.max_gens, search_space, @bee.num_bees, @bee.num_sites, @bee.elite_sites, @bee.patch_size.to_f, @bee.e_bees, @bee.o_bees)
    puts "done! Solution: f=#{@best[:fitness]}, s=#{@best[:vector].inspect}"
  end
  def objective_function(vector)
    return vector.inject(0.0) {|sum, x| sum +  (x ** 2.0)}
  end

  def random_vector(minmax)
    return Array.new(minmax.size) do |i|
      minmax[i][0] + ((minmax[i][1] - minmax[i][0]) * rand())
    end
  end

  def create_random_bee(search_space)
    return {:vector=>random_vector(search_space)}
  end

  def create_neigh_bee(site, patch_size, search_space)
    vector = []
    site.each_with_index do |v,i|
      v = (rand()<0.5) ? v+rand()*patch_size : v-rand()*patch_size
      v = search_space[i][0] if v < search_space[i][0]
      v = search_space[i][1] if v > search_space[i][1]
      vector << v
    end
    bee = {}
    bee[:vector] = vector
    return bee
  end

  def search_neigh(parent, neigh_size, patch_size, search_space)
    neigh = []
    neigh_size.times do
      neigh << create_neigh_bee(parent[:vector], patch_size, search_space)
    end
    neigh.each{|bee| bee[:fitness] = objective_function(bee[:vector])}
    return neigh.sort{|x,y| x[:fitness]<=>y[:fitness]}.first
  end

  def create_scout_bees(search_space, num_scouts)
    return Array.new(num_scouts) do
      create_random_bee(search_space)
    end
  end

  def search(max_gens, search_space, num_bees, num_sites, elite_sites, patch_size, e_bees, o_bees)
    best = nil
    pop = Array.new(num_bees){ create_random_bee(search_space) }
    max_gens.times do |gen|
      pop.each{|bee| bee[:fitness] = objective_function(bee[:vector])}
      pop.sort!{|x,y| x[:fitness]<=>y[:fitness]}
      best = pop.first if best.nil? or pop.first[:fitness] < best[:fitness]
      next_gen = []
      pop[0...num_sites].each_with_index do |parent, i|
        neigh_size = (i<elite_sites) ? e_bees : o_bees
        next_gen << search_neigh(parent, neigh_size, patch_size, search_space)
      end
      scouts = create_scout_bees(search_space, (num_bees-num_sites))
      pop = next_gen + scouts
      patch_size = patch_size * 0.95
      puts " > it=#{gen+1}, patch_size=#{patch_size}, f=#{best[:fitness]}"
    end
    return best
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bee
      @bee = Bee.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bee_params
      params.require(:bee).permit(:problem_size, :search_space, :max_gens, :num_bees, :num_sites, :elite_sites, :patch_size, :e_bees, :o_bees)
    end
end
