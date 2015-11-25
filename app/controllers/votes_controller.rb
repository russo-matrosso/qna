class VotesController < ApplicationController
  # before_action :authenticate_user!
  before_action :load_parent

  def vote_up
    current_user.vote_up_for(@parent)
    redirect_to :back, notice: "Voted up"
  end

  def vote_down
    current_user.vote_down_for(@parent)
    redirect_to :back, notice: "Unvoted"
  end

  private

  def load_parent
    resource, id = request.path.split("/")[1, 2]
    @parent = resource.singularize.classify.constantize.find(id)
  end
end