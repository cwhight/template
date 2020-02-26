require 'test_helper'

class OfferControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get offer_new_url
    assert_response :success
  end

end
