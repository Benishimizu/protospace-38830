class PrototypesController < ApplicationController

  private

  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
    # params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
  end

  def new
    # @prototype = Prototype.new
  end
    # https://master.tech-camp.in/v2/curriculums/4217

  def create
    # @prototype = Prototype.new(prototype_params)
    # if @prototype.save
    #   redirect_to root_path
    # else
    #   render :new
    # end
  end
    # https://master.tech-camp.in/v2/curriculums/4762


end
