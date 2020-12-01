require 'test_helper'

class ProfilesControllerTest < ActionDispatch::IntegrationTest
<<<<<<< HEAD
  test "should get new" do
    get profiles_new_url
    assert_response :success
  end

  test "should get create" do
    get profiles_create_url
=======
  test "should get index" do
    get profiles_index_url
    assert_response :success
  end

  test "should get show" do
    get profiles_show_url
>>>>>>> c74fff52758b2f0a0d7378de7b6b9526f21b5d56
    assert_response :success
  end

end
