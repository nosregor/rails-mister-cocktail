class DosesController < ApplicationController
  before_action :find_dose, only: [:edit, :destroy, :update]
  before_action :find_cocktail, only: [ :new, :create, :edit, :update, :destroy]

  def new
    @dose = Dose.new
    @ingredients = Ingredient.all

    # Alternative method: A
    #@ingredients_and_ids = Ingredient.pluck(:name, :id)
  end

  def create
    #binding.pry
    # Alterntive method: AR
    # @dose = Dose.new(
    #   description: dose_params[:description],
    #   cocktail: @cocktail,
    #   ingredient: Ingredient.find(dose_params[:ingredient])
    #   )

    # Refactored:
    @dose = Dose.new(dose_params.merge({ cocktail: @cocktail }))
    # @dose.cocktail = @cocktail

    if @dose.save
      flash[:notice] = "New ingredient added successfully."
      redirect_to cocktail_path(@cocktail)
    else
      flash[:alert] = 'Try again.'
      @ingredients = Ingredient.all

      # Alternative method: AR
      # @ingredients_and_ids = Ingredient.pluck(:name, :id)
      render :new
    end

  end

  def destroy
    @dose.destroy
    flash[:notice] = "Ingredient deleted successfully."

    redirect_to cocktail_path(@cocktail)
  end

  def edit
    @ingredients = Ingredient.all

    # Alternative method: AR
    # @ingredients_and_ids = Ingredient.pluck(:name, :id)
    # raise
  end

  def update
    # raise
    @dose.update(dose_params)

    # Alternative method: AR
    # @dose = Dose.update(
    #   description: dose_params[:description],
    #   ingredient: Ingredient.find(dose_params[:ingredient])
    #   )

    redirect_to cocktail_path(@cocktail)
  end


  private

  def dose_params
    params.require(:dose).permit(:description, :ingredient_id)
    # alternative method
    #params.require(:dose).permit(:description, :ingredient)
  end

  def find_cocktail
    @cocktail = Cocktail.find(params[:cocktail_id])
  end

  def find_dose
    @dose = Dose.find(params[:id])
  end

end

