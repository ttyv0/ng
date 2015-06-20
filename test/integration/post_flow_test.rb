require 'test_helper'

class PostFlowTest < ActionDispatch::IntegrationTest
	test "post flow" do
		get "/"
		assert_select "title", "NothingGood"

		get "/users/sign_up"
		assert_select "h2", "Sign up"
		assert_select "form.new_user" do
			assert_select "input#user_name"
			assert_select "input#user_email"
			assert_select "input#user_password"
			assert_select "input#user_password_confirmation"
			assert_select "div.actions" do
				assert_select "input"
			end
		end

		post "/users", user: { name: "user_integr", email: "user@inte.gr", password: "integr_pa55", password_confirmation: "integr_pa55" }
		assert_response :redirect
		follow_redirect!
		assert_response :success
		assert_template "posts/index"

		delete "/users/sign_out"
		assert_response :redirect
		follow_redirect!
		assert_response :success
		assert_template "posts/index"
		assert_select "ul.dropdown-menu" do
			assert_select "li", "Sign in"
			assert_select "li", "Sign up"
		end

		get "/users/sign_in"
		assert_select "h2", "Log in"
		assert_select "form.new_user" do
			assert_select "input#user_name"
			assert_select "input#user_password"
			assert_select "input#user_remember_me"
			assert_select "div.actions" do
				assert_select "input"
			end
		end

		post "/users/sign_in", user: { name: "user_integr", password: "integr_pa55" }
		assert_response :redirect
		follow_redirect!
		assert_response :success
		assert_template "posts/index"
		assert_select "li.dropdown" do
			assert_select "a", "user_integr"
		end

		get "/new"
		assert_select "form.new_post"
		assert_template "posts/new"

		post "/", post: { title: "integr_post1" }, comment: { message: "integr_message" }
		assert_response :redirect
		follow_redirect!
		assert_response :success
		assert_template "posts/show"

		integr_post_id = Post.find_by( title: "integr_post1" ).id
		post "/" + integr_post_id.to_s + "/comment", comment: { message: "2 integr_massage" }
		assert_response :redirect
		follow_redirect!
		assert_response :success
		assert_template "posts/show"
	end
end
