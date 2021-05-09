class CommentsController < ApplicationController
    def create
        @post = Post.find(params[:post_id])
        @comment = @post.comments.build(comment_params)
        @comment.commenter = current_user.name
        @comment.save
        redirect_to post_path(@post)
    end
    
    private
    def comment_params
        params.require(:comment).permit(:commenter, :body)
    end
end
