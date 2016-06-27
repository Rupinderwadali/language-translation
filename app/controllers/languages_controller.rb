class LanguagesController < ApplicationController
  load_and_authorize_resource

  def index
   @languages = Language.all
  if params[:search]
    @languages = Language.search(params[:search]).order("created_at DESC")
  else
    @languages = Language.all.order('created_at DESC')
  end

  end

  def show
    respond_to do |format|
      format.html { render nothing: true }
    end
  end

  def new
    @language = Language.new
  end

  def edit
    @language = Language.find(params[:id])
  end

  def create
    @language = Language.new(language_params)

    if @language.save
      redirect_to edit_language_path(@language)
    else
      render 'new'
    end
  end

  def update
    @language = Language.find(params[:id])

    if @language.update(language_params)
      redirect_to edit_language_path(@language)
    else
      render 'edit'
    end
  end

  def destroy
    @language = Language.find(params[:id])
    @language.destroy

    redirect_to languages_path
  end

  private
  # Never trust parameters from the scary internet, only allow the white list through.
  def language_params
    params.require(:language).permit(:name)
  end
end
