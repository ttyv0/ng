require 'test_helper'

class PostTest < ActiveSupport::TestCase
  test "post attributes not be empty" do
    post = Post.new
    assert post.invalid?
    assert post.errors[:title].any?
    assert post.errors[:user_id].any?
  end

  test "post title not be blank" do
    post = Post.new(title: ' ', user_id: '1')
    assert post.invalid?
  end
end
