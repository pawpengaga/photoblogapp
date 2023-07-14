class CommentsController < ApplicationController
  before_action :set_comment, only: %i[ show edit update destroy ]
  before_action only: [:edit, :update, :destroy] do
      authorize_request(["admin"])
    end
    
  def index
      @user = User.find(params[:user_id])
      @comments = @user.comments
  end

  def create
      @publication = Publication.find(params[:comment][:publication_id])
      
      @comment = Comment.new(comment_params)
      @comment.user = current_user

      # if client_signed_in?
      #     @comment.user.id = current_user.id
      # else
      #     @comment.user_id = 2
      # end

      respond_to do |format|
          if @comment.save
              format.html { redirect_to publication_path(@publication.id), notice: 'Comment was successfully created.' }
          else
              format.html { redirect_to publication_path(@publication.id), notice: 'Comment was not created.' }
          end
      end
  end

  def destroy
      @publication = Publication.find(params[:publication_id])
      @comment = @publication.comments.find(params[:id])
      @comment.destroy
      redirect_to publication_path(@publication), notice: 'Comment was successfully deleted.'
    end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
      params.require(:comment).permit(:content, :publication_id, :user_id)
  end
end
