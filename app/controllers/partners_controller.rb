class PartnersController < ApplicationController
  def create
    @partner = Partner.new(partner_params)

    if @partner.save
      render :create, status: :created
    else
      render json: @partner.errors, status: :unprocessable_entity
    end
  end

  private

  def partner_params
    params.require(:partner).permit(:name)
  end
end
