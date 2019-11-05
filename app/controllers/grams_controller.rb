class GramsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def new
    @gram = Gram.new
  end

  def create
    @gram = current_user.grams.create(gram_params)
    if @gram.valid? then
      redirect_to root_path
    else
      return render :new, status: :unprocessable_entity
    end
  end

  def index
  end

  private

  def gram_params
    params.require(:gram).permit(:message)
  end

end