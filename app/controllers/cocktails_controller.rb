class CocktailsController < ApplicationController
  before_action :set_cocktail, only: [:show, :edit, :update, :destroy]

  # GET /cocktails
  def index
    @cocktails = Cocktail.all
  end

  # GET /cocktails/1
  def show
  end

  # GET /cocktails/new
  def new
    @cocktail = Cocktail.new
    flash[:notice] = "You have created #{@cocktail.name} successfully."
  end

  # GET /cocktails/1/edit
  def edit
    @dose = Dose.new
    @ingredient = Ingredient.all

    # Alternative method: AR
    #@ingredients_and_ids = Ingredient.pluck(:name, :id)
  end


  # POST /cocktails
  def create
    #Cocktail.create(cocktail_params)

    @cocktail = Cocktail.new(cocktail_params)
    if @cocktail.save
      flash[:notice] = "You have created #{@cocktail.name} successfully."
      redirect_to cocktail_path(@cocktail)
    else
      render :new
    end

  end

  # PATCH/PUT /cocktails/1
  def update
    @cocktail.update(cocktail_params)
    flash[:notice] = "You have updated #{@cocktail.name} successfully."
    redirect_to cocktails_path
  end

  # DELETE /cocktails/1
  def destroy
    @cocktail.destroy
    flash[:notice] = "You have deleted #{@cocktail.name} successfully."
    redirect_to cocktails_path
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cocktail
      @cocktail = Cocktail.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cocktail_params
      params.require(:cocktail).permit(:name, :picture, :picture_cache)
    end
end
