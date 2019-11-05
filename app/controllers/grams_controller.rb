class GramsController < ApplicationController
  def new
    @gram = Gram.new
  end

  def create
    @gram = Gram.create(gram_params)
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