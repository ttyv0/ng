require 'test_helper'

class PostFlowTest < ActionDispatch::IntegrationTest
	test "can see the root page" do
		get "/"
		assert_select 'title', "NothingGood"
	end
end
