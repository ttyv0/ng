class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def index
    @posts = Post.all
  end

  def show
		@comment = Comment.new
  end

  def new
		if user_signed_in? 
			@post = current_user.posts.build
			@comment = current_user.comments.build
		else
			redirect_to posts_url, notice: 'Access denied!'
		end
  end

  def edit
		if user_signed_in? 
			if @post.user_id != current_user.id
				redirect_to post_url, notice: 'Access denied!'
			end
				@comment = @post.comments.first
		else
			redirect_to posts_url, notice: 'Access denied!'
		end
  end

	def create
		@post = current_user.posts.build(post_params)
		@comment = current_user.comments.build(comment_params)
		if @post.valid? && @comment.valid?
			@post.save
			@comment.post_id = @post.id
			@comment.save
			redirect_to @post, notice: 'Post was successfully created.'
		else
			render :new
		end
	end

	def update
		if @post.update(post_params) && @post.comments.first.update(comment_params)
			redirect_to @post, notice: 'Post was successfully updated.'
		else
			render :edit
		end
	end

  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

	def create_comment
		if user_signed_in?
			@comment = current_user.comments.build(comment_params)
			@comment.post_id = params[:post_id]
			@comment.save
			redirect_to post_path(params[:post_id])
		end
	end

  private
    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:title)
		end

		def comment_params
			params.require(:comment).permit(:message)
		end

end
