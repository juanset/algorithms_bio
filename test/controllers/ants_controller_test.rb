require 'test_helper'

class AntsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @ant = ants(:one)
  end

  test "should get index" do
    get ants_url
    assert_response :success
  end

  test "should get new" do
    get new_ant_url
    assert_response :success
  end

  test "should create ant" do
    assert_difference('Ant.count') do
      post ants_url, params: { ant: { c_heur: @ant.c_heur, c_hist: @ant.c_hist, decay_factor: @ant.decay_factor, max_it: @ant.max_it, num_ants: @ant.num_ants, set: @ant.set } }
    end

    assert_redirected_to ant_url(Ant.last)
  end

  test "should show ant" do
    get ant_url(@ant)
    assert_response :success
  end

  test "should get edit" do
    get edit_ant_url(@ant)
    assert_response :success
  end

  test "should update ant" do
    patch ant_url(@ant), params: { ant: { c_heur: @ant.c_heur, c_hist: @ant.c_hist, decay_factor: @ant.decay_factor, max_it: @ant.max_it, num_ants: @ant.num_ants, set: @ant.set } }
    assert_redirected_to ant_url(@ant)
  end

  test "should destroy ant" do
    assert_difference('Ant.count', -1) do
      delete ant_url(@ant)
    end

    assert_redirected_to ants_url
  end
end
