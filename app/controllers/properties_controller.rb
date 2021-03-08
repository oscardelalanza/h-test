class PropertiesController < ApplicationController
  before_action :authenticate_owner!
  before_action :find_property, only: %i[show update delete]

  def index
    @properties = current_owner.properties
  end

  def show
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
      render_errors
    end
  end

  def update
    @property&.update(property_params)

    if @property.save
      render :show, status: :created
    else
      render_errors
    end
  end

  def destroy; end

  private

  def property_params
    params.require(:property).permit(:name, :description, :status, :rental_price)
  end

  def find_property
    @property = Property.find_by(id: params[:id], owner_id: current_owner.id)
  end

  def render_errors
    render json: @property.errors, status: :unprocessable_entity
  end
end
