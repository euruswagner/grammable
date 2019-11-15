class GramsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

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
    @grams = Gram.all
  end

  def edit
    @gram = Gram.find_by_id(params[:id])
    return render_not_found if @gram.blank?
    return render_not_found(:forbidden) if @gram.user != current_user
  end

  def update
    @gram = Gram.find_by_id(params[:id])
    return render_not_found if @gram.blank?
    return render_not_found(:forbidden) if @gram.user != current_user

    @gram.update_attributes(gram_params)
    
    return is_valid
  end

  def destroy
    @gram = Gram.find_by_id(params[:id])
    return render_not_found if @gram.blank?
    return render_not_found(:forbidden) if @gram.user != current_user

    @gram.destroy
    redirect_to root_path
  end

  private

  def gram_params
    params.require(:gram).permit(:message, :picture)
  end

  def is_valid
    if @gram.valid? then
      return redirect_to root_path
    else
      return render :new, status: :unprocessable_entity
    end
  end
end