class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_parent

  respond_to :json

  def create
    @comment = @parent.comments.create(comment_params.merge(user_id: current_user.id))
    respond_with(@comment, root: false)
  end

  private

  def load_parent
    resource, id = request.path.split("/")[1, 2]
    @parent = resource.singularize.classify.constantize.find(id)
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
