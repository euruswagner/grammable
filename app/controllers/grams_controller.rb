class GramsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def show
    @gram = Gram.find_by_id(params[:id])
    return render_not_found if @gram.blank?
  end

  def new
    @gram = Gram.new
  end

  def create
    @gram = current_user.grams.create(gram_params)
    
    return is_valid
  end

  def index
  end

  def edit
    @gram = Gram.find_by_id(params[:id])
    return render_not_found if @gram.blank?
  end

  def update
    @gram = Gram.find_by_id(params[:id])
    return render_not_found if @gram.blank?

    @gram.update_attributes(gram_params)
    
    return is_valid
  end

  private

  def gram_params
    params.require(:gram).permit(:message)
  end

  def render_not_found
    render plain: 'Not Found :(', status: :not_found
  end

  def is_valid
    if @gram.valid? then
      redirect_to root_path
    else
      return render :new, status: :unprocessable_entity
    end
  end
end