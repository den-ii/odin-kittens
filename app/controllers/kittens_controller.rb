class KittensController < ApplicationController
  protect_from_forgery with: :null_session
  skip_before_action :verify_authenticity_token, only: [:create]

  def index
    @kittens = Kitten.all
    render json: {kittens: @kittens}
  end

  def show
    puts params
    @kitten = Kitten.find(params[:id])
    render json: {kitten: @kitten}
    rescue ActiveRecord::RecordNotFound
      render json: { error: 'Kitten not found' }, status: :not_found
  end

  def create
    puts params
    @kitten = Kitten.new(kitten_params)
    if @kitten.save
      render json: {kitten: @kitten, status: :created}
    else
      render json: {errors: @kitten.errors, status: :unprocessable_entity}
    end
  end

  def new
    create
  end


  def destroy
    @kitten = Kitten.find(params[:id])
    @kitten.destroy
    render json: {kitten: @kitten, status: :destroyed}
    rescue ActiveRecord::RecordNotFound
    render json: { error: 'Kitten not found' }, status: :not_found
  end


  private

  def kitten_params
    params.require(:kitten).permit(:name, :age, :cuteness, :softness)
  end
end