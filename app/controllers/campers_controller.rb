class CampersController < ApplicationController 

    def index 
        camper = Camper.all 
        render json:camper
    end 

    def show
        camper = Camper.find_by(id: params[:id])  
        if camper
            render json: camper.to_json( include: :activities), status: :ok 
        else
              render json: { error: "Camper not found" }, status: :not_found
        end
    end

    def create 
        camper = Camper.create(params_camper) 
        if camper.valid?
        render json: camper, status: :created 
        else 
            render json: { errors: camper.errors.full_messages }, status: :unprocessable_entity 
        end
    end

    private 

    def params_camper
        params.permit(:name, :age)
    end


end
