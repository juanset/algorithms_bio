require 'test_helper'

class BeesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @bee = bees(:one)
  end

  test "should get index" do
    get bees_url
    assert_response :success
  end

  test "should get new" do
    get new_bee_url
    assert_response :success
  end

  test "should create bee" do
    assert_difference('Bee.count') do
      post bees_url, params: { bee: { e_bees: @bee.e_bees, elite_sites: @bee.elite_sites, max_gens: @bee.max_gens, num_bees: @bee.num_bees, num_sites: @bee.num_sites, o_bees: @bee.o_bees, patch_size: @bee.patch_size, problem_size: @bee.problem_size, search_space: @bee.search_space } }
    end

    assert_redirected_to bee_url(Bee.last)
  end

  test "should show bee" do
    get bee_url(@bee)
    assert_response :success
  end

  test "should get edit" do
    get edit_bee_url(@bee)
    assert_response :success
  end

  test "should update bee" do
    patch bee_url(@bee), params: { bee: { e_bees: @bee.e_bees, elite_sites: @bee.elite_sites, max_gens: @bee.max_gens, num_bees: @bee.num_bees, num_sites: @bee.num_sites, o_bees: @bee.o_bees, patch_size: @bee.patch_size, problem_size: @bee.problem_size, search_space: @bee.search_space } }
    assert_redirected_to bee_url(@bee)
  end

  test "should destroy bee" do
    assert_difference('Bee.count', -1) do
      delete bee_url(@bee)
    end

    assert_redirected_to bees_url
  end
end
