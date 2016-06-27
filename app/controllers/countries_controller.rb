class CountriesController < ApplicationController
  load_and_authorize_resource

  def index
    if current_user.has_role? :superadmin
      @countries = Country.all
      if params[:search]
       @countries = Country.search(params[:search]).order("created_at DESC")
      else
       @countries = Country.all.order('created_at DESC')
      end
    else
      @countries = current_user.organization.countries
      if params[:search]
    @countries = Country.search(params[:search]).order("created_at DESC")
  else
    @countries = current_user.organization.countries.order('created_at DESC')
  end


    end
  end

  def show
    @country = Country.find(params[:id])
  end

  def new
    @country = Country.new
  end

  def edit
    @country = Country.find(params[:id])
  end

  def create
    @country = Country.new(country_params)
    @country.organization_id = current_user.organization.id

    if @country.save
      redirect_to @country
    else
      render 'new'
    end
  end

  def update
    @country = Country.find(params[:id])

    if @country.update(country_params)
      redirect_to @country
    else
      render 'edit'
    end
  end

  def destroy
    @country = Country.find(params[:id])
    @country.destroy

    redirect_to countries_path
  end

  private
  # Never trust parameters from the scary internet, only allow the white list through.
  def country_params
    params.require(:country).permit(:name, :user_id, :organization_id)
  end
end
