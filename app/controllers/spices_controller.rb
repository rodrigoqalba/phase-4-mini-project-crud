class SpicesController < ApplicationController

    def index
        spices = Spice.all
        render json: spices
    end

    def create
        spice = Spice.create(spice_params)
        if spice.valid?
            render json: spice, status: :created
        else
            render json: { error: spice.errors }, status: :unprocessable_entity
        end
    end

    def update
        spice = Spice.find_by(id: params[:id])
        if spice.update(spice_params)
            render json: spice, status: :ok
        else
            render json: { error: "Spice not found" }, status: :unprocessable_entity
        end
    end

    def destroy
        spice = Spice.find_by(id: params[:id])
        if spice
            spice.destroy
            head :no_content
        else
            render json: { error: errors.message }, status: :not_found
        end
    end

    private

    def spice_params
        params.permit(:title, :image, :description, :notes, :rating)
    end
end
