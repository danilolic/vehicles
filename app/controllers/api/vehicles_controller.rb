module Api
  class VehiclesController < ApplicationController
    before_action :authorize_access_request!, except: :index
    before_action :set_vehicle, only: %i[show update destroy]
    before_action :set_model, only: %i[index create]

    # GET api/models/:model_id/vehicles
    def index
      @vehicles = @model.vehicles.order(:value)
    end

    # GET api/vehicles/1
    def show; end

    # POST api/models/:model_id/vehicles
    def create
      @vehicle = @model.vehicles.build(vehicle_params)

      if @vehicle.save
        render 'api/vehicles/show.json', status: :created
      else
        render json: @vehicle.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT api/vehicles/1
    def update
      if @vehicle.update(vehicle_params)
        render 'api/vehicles/show.json', status: :ok
      else
        render json: @vehicle.errors, status: :unprocessable_entity
      end
    end

    # DELETE api/vehicles/1
    def destroy
      @vehicle.destroy
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_vehicle
      @vehicle = Vehicle.find(params[:id])
    end

    def set_model
      @model = Model.find(params[:model_id])
    end

    # Only allow a trusted parameter "white list" through.
    def vehicle_params
      params.require(:vehicle).permit(:value, :model_id, :year_model, :fuel)
    end
  end
end
