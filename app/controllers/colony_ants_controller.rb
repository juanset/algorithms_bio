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
  #----------------Ant System colony Algoritmh----------------#

  def euc_2d(c1, c2)
    Math.sqrt((c1[0] - c2[0])**2.0 + (c1[1] - c2[1])**2.0).round
  end

  def cost(permutation, cities)
    distance =0
    permutation.each_with_index do |c1, i|
      c2 = (i==permutation.size-1) ? permutation[0] : permutation[i+1]
      distance += euc_2d(cities[c1], cities[c2])
    end
    return distance
  end

  def random_permutation(cities)
    perm = Array.new(cities.size){|i| i}
    perm.each_index do |i|
      r = rand(perm.size-i) + i
      perm[r], perm[i] = perm[i], perm[r]
    end
    return perm
  end

  def initialise_pheromone_matrix(num_cities, init_pher)
    return Array.new(num_cities){|i| Array.new(num_cities, init_pher)}
  end

  def calculate_choices(cities, last_city, exclude, pheromone, c_heur, c_hist)
    choices = []
    cities.each_with_index do |coord, i|
      next if exclude.include?(i)
      prob = {:city=>i}
      prob[:history] = pheromone[last_city][i] ** c_hist
      prob[:distance] = euc_2d(cities[last_city], coord)
      prob[:heuristic] = (1.0/prob[:distance]) ** c_heur
      prob[:prob] = prob[:history] * prob[:heuristic]
      choices << prob
    end
    return choices
  end

  def prob_select(choices)
    sum = choices.inject(0.0){|sum,element| sum + element[:prob]}
    return choices[rand(choices.size)][:city] if sum == 0.0
    v = rand()
    choices.each_with_index do |choice, i|
      v -= (choice[:prob]/sum)
      return choice[:city] if v <= 0.0
    end
    return choices.last[:city]
  end

  def greedy_select(choices)
    return choices.max{|a,b| a[:prob]<=>b[:prob]}[:city]
  end

  def stepwise_const(cities, phero, c_heur, c_greed)
    perm = []
    perm << rand(cities.size)
    begin
      choices = calculate_choices(cities, perm.last, perm, phero, c_heur, 1.0)
      greedy = rand() <= c_greed
      next_city = (greedy) ? greedy_select(choices) : prob_select(choices)
      perm << next_city
    end until perm.size == cities.size
    return perm
  end

  def global_update_pheromone(phero, cand, decay)
    cand[:vector].each_with_index do |x, i|
      y = (i==cand[:vector].size-1) ? cand[:vector][0] : cand[:vector][i+1]
      value = ((1.0-decay)*phero[x][y]) + (decay*(1.0/cand[:cost]))
      phero[x][y] = value
      phero[y][x] = value
    end
  end

  def local_update_pheromone(pheromone, cand, c_local_phero, init_phero)
    cand[:vector].each_with_index do |x, i|
      y = (i==cand[:vector].size-1) ? cand[:vector][0] : cand[:vector][i+1]
      value = ((1.0-c_local_phero)*pheromone[x][y])+(c_local_phero*init_phero)
      pheromone[x][y] = value
      pheromone[y][x] = value
    end
  end

  def search(cities, max_it, num_ants, decay, c_heur, c_local_phero, c_greed)
    best = {:vector=>random_permutation(cities)}
    best[:cost] = cost(best[:vector], cities)
    init_pheromone = 1.0 / (cities.size.to_f * best[:cost])
    pheromone = initialise_pheromone_matrix(cities.size, init_pheromone)
    max_it.times do |iter|
      solutions = []
      num_ants.times do
        cand = {}
        cand[:vector] = stepwise_const(cities, pheromone, c_heur, c_greed)
        cand[:cost] = cost(cand[:vector], cities)
        best = cand if cand[:cost] < best[:cost]
        local_update_pheromone(pheromone, cand, c_local_phero, init_pheromone)
      end
      global_update_pheromone(pheromone, best, decay)
      puts " > Iteracion #{(iter+1)}, Mejor=#{best[:cost]}"
    end
    return best
  end

  def algorithm()
    @colony_ant = ColonyAnt.find(params[:id])
    #@berlin52 =  JSON.parse(@ant.set)
    reg = /(?<=\[)[\d,?\s?]+(?=\])/
    @berlin52 = @colony_ant.set.scan(reg).map { |s| s.scan(/\d+/).map(&:to_i) }
    #@berlin52= [[565,575],[25,185],[345,750],[945,685],[845,655],[880,660],[25,230],[525,1000],[580,1175],[650,1130],[1605,620],[1220,580],[1465,200],[1530,5],[845,680],[725,370],[145,665], [415,635],[510,875],[560,365],[300,465],[520,585],[480,415], [835,625],[975,580],[1215,245],[1320,315],[1250,400],[660,180],[410,250],[420,555],[575,665],[1150,1160],[700,580],[685,595],[685,610],[770,610],[795,645],[720,635],[760,650],[475,960],              [95,260],[875,920],[700,500],[555,815],[830,485],[1170,65],[830,610],[605,625],[595,360],[1340,725],[1740,245]]
    @best = search(@berlin52, @colony_ant.max_it, @colony_ant.num_ants, @colony_ant.decay.to_f, @colony_ant.c_heur.to_f, @colony_ant.c_local_phero.to_f, @colony_ant.c_greed.to_f)
    puts "Terminado. Mejor solucion: c=#{@best[:cost]}, v=#{@best[:vector].inspect}"
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
