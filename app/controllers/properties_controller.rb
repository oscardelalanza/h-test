class PropertiesController < ApplicationController
  before_action :authenticate_owner!

  def index
    @properties = current_owner.properties
  end

  def show
    @property = Property.find_by(id: params[:id], owner_id: current_owner.id)
    if @property
      render :show, status: :ok
    else
      head(:not_found)
    end
  end

  def create
    @property = current_owner.properties.build(property_params)
    if @property.save
      render :show, status: :created
    else
      render json: @property.errors, status: :unprocessable_entity
    end
  end

  def update; end

  def destroy; end

  private

  def property_params
    params.require(:property).permit(:name, :description, :status, :rental_price)
  end
end
