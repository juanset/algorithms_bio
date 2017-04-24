require 'test_helper'

class ColonyAntsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @colony_ant = colony_ants(:one)
  end

  test "should get index" do
    get colony_ants_url
    assert_response :success
  end

  test "should get new" do
    get new_colony_ant_url
    assert_response :success
  end

  test "should create colony_ant" do
    assert_difference('ColonyAnt.count') do
      post colony_ants_url, params: { colony_ant: { c_greed: @colony_ant.c_greed, c_heur: @colony_ant.c_heur, c_local_phero: @colony_ant.c_local_phero, decay: @colony_ant.decay, max_it: @colony_ant.max_it, num_ants: @colony_ant.num_ants, set: @colony_ant.set } }
    end

    assert_redirected_to colony_ant_url(ColonyAnt.last)
  end

  test "should show colony_ant" do
    get colony_ant_url(@colony_ant)
    assert_response :success
  end

  test "should get edit" do
    get edit_colony_ant_url(@colony_ant)
    assert_response :success
  end

  test "should update colony_ant" do
    patch colony_ant_url(@colony_ant), params: { colony_ant: { c_greed: @colony_ant.c_greed, c_heur: @colony_ant.c_heur, c_local_phero: @colony_ant.c_local_phero, decay: @colony_ant.decay, max_it: @colony_ant.max_it, num_ants: @colony_ant.num_ants, set: @colony_ant.set } }
    assert_redirected_to colony_ant_url(@colony_ant)
  end

  test "should destroy colony_ant" do
    assert_difference('ColonyAnt.count', -1) do
      delete colony_ant_url(@colony_ant)
    end

    assert_redirected_to colony_ants_url
  end
end
