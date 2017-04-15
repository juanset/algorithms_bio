require 'test_helper'

class ResultadoControllerTest < ActionDispatch::IntegrationTest
  test "should get bee" do
    get resultado_bee_url
    assert_response :success
  end

  test "should get ant" do
    get resultado_ant_url
    assert_response :success
  end

end
