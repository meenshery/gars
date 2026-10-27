class CollectionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_collection, only: %i[show edit update destroy]

  def index
    @collections = current_user.collections
  end

  def show
  end

  def new
    @collection = current_user.collections.new
    authorize! :create, @collection
  end

  def edit
  end

  def create
    @collection = current_user.collections.new(collection_params)
    authorize! :create, @collection

    respond_to do |format|
      if @collection.save
        format.html { redirect_to @collection, notice: "Коллекция создана" }
        format.json { render :show, status: :created, location: @collection }
      else
        format.html { render :new, status: :unprocessable_content }
        format.json { render json: @collection.errors, status: :unprocessable_content }
      end
    end
  end

  def update
    respond_to do |format|
      if @collection.update(collection_params)
        format.html { redirect_to @collection, notice: "Коллекция сохранена", status: :see_other }
        format.json { render :show, status: :ok, location: @collection }
      else
        format.html { render :edit, status: :unprocessable_content }
        format.json { render json: @collection.errors, status: :unprocessable_content }
      end
    end
  end

  def destroy
    @collection.destroy!

    respond_to do |format|
      format.html { redirect_to collections_path, notice: "Коллекция удалена", status: :see_other }
      format.json { head :no_content }
    end
  end

  private

  def set_collection
    @collection = current_user.collections.find(params.expect(:id))
    authorize! :manage, @collection
  end

  def collection_params
    params.expect(collection: [:title, :description, :collection_type])
  end
end