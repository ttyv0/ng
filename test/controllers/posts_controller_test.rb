require 'test_helper'

class PostsControllerTest < ActionController::TestCase
	include Devise::TestHelpers
  setup do
		sign_in User.find_by(name: 'user1')
		@post = posts(:post_one)
		@post_update = {
			title: 'Test title post'
		}
		@comment_update = {
			message: 'Test message'
		}
		@denied = 'Access denied!'
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:posts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create post" do
    assert_difference('Post.count') do
			post :create, post: @post_update, comment: @comment_update
    end

    assert_redirected_to post_path(assigns(:post))
  end

	test 'should create comment' do
		assert_difference('Comment.count') do
			post :create_comment, post_id: @post, comment: @comment_update 
		end

		assert_redirected_to post_path(@post.id)
	end

	test "should not create post" do
		assert_no_difference('Post.count') do
			sign_out User.find_by(name: 'user1')
			post :create, post: @post_update, comment: @comment_update
		end

		assert_redirected_to posts_path
		assert_equal @denied, flash[:notice]
	end


	test "should not create comment" do
		assert_no_difference('Comment.count') do
			sign_out User.find_by(name: 'user1')
			post :create_comment, post_id: @post, comment: @comment_update
		end

		assert_redirected_to post_path(@post.id)
		assert_equal @denied, flash[:notice]
	end

  test "should show post" do
    get :show, id: @post
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @post
    assert_response :success
  end

  test "should update post" do
		patch :update, id: @post, post: @post_update, comment: @comment_update
    assert_redirected_to post_path(assigns(:post))
  end

  test "should destroy post" do
    assert_difference('Post.count', -1) do
      delete :destroy, id: @post
    end

    assert_redirected_to posts_path
	end

	test "should route to article" do
		assert_routing '/1', { controller: 'posts', action: 'show', id: '1' }
	end

	test "should route to new comment" do
		assert_routing( { method: 'post', path: '/1/comment' }, { controller: 'posts', action: 'create_comment', post_id: '1' } )
	end

end
