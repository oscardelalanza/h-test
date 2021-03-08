class PartnersController < ApplicationController
  def create
    @partner = Partner.new(partner_params)

    if @partner.save
      render :create, status: :created
    else
      render json: @partner.errors, status: :unprocessable_entity
    end
  end

  def published_properties
    if validate_token
      @properties = Property.all.published
      render :published_properties, status: :ok
    else
      head(:forbidden)
    end
  end

  private

  def partner_params
    params.require(:partner).permit(:name)
  end

  def validate_token
    Partner.find_by(auth_token: params[:token])
  end
end
