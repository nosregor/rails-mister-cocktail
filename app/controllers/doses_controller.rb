class DosesController < ApplicationController
  before_action :find_dose, only: [:edit, :destroy, :update]
  before_action :find_cocktail, only: [ :new, :create, :edit, :update, :destroy]

  def new
    @dose = Dose.new
    #@ingredients_and_ids = Ingredient.pluck(:name, :id)

    # Inous metod
    @ingredients = Ingredient.all
  end

  def create
    #binding.pry
    # @dose = Dose.new(
    #   description: dose_params[:description],
    #   cocktail: @cocktail,
    #   ingredient: Ingredient.find(dose_params[:ingredient])
    #   )

    # inous method
    @dose = Dose.new(dose_params.merge({ cocktail: @cocktail }))
    # @dose.cocktail = @cocktail

    if @dose.save
      flash[:notice] = 'It worked'
      redirect_to cocktail_path(@cocktail)
    else
      flash[:alert] = 'It didnt do anything'
      #@ingredients_and_ids = Ingredient.pluck(:name, :id)
      @ingredients = Ingredient.all
      render :new
    end

  end

  def destroy
    @dose.delete
    redirect_to cocktail_path(@cocktail)
  end

  def edit
    #@ingredients_and_ids = Ingredient.pluck(:name, :id)
    #raise
    @ingredients = Ingredient.all
  end

  def update
    flash[:notice] = "You have updated #{@cocktail.name}"
    # @dose = Dose.update(
    #   description: dose_params[:description],
    #   ingredient: Ingredient.find(dose_params[:ingredient])
    #   )

    # inous method
    @dose.update(dose_params)

    redirect_to cocktail_path(@cocktail)
  end

  private
  def dose_params
    #params.require(:dose).permit(:description, :ingredient)

    # inous method
    params.require(:dose).permit(:description, :ingredient_id)

  end

  def find_cocktail
    @cocktail = Cocktail.find(params[:cocktail_id])
  end

  def find_dose
    @dose = Dose.find(params[:id])
  end

end

