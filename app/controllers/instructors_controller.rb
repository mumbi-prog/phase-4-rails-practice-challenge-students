class InstructorsController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :render_record_not_found
rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity

    def index
        render json: Instructor.all, status: :ok
    end

    def show
        instructor = find_instructor
        render json: instructor, status: :ok
    end

    def create
        instructor = Instructor.create!(instructor_params)
        render json: instructor, status: :created
    end

    def update
        instructor = find_instructor
        instructor.update!(instructor_params)
        instructor.save!
        render json: instructor, status: :accepted
    end

    def destroy
        instructor = find_instructor
        instructor.destroy!
        head :no_content
    end

    private

    def instructor_params
        params.permit(:name)
    end

    def find_instructor
        instructor = Instructor.find_by(id: params[:id])
    end

    def render_unprocessable_entity(invalid)
        render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
    end

    def render_record_not_found
        render json: {error: "Instructor not found" }, status: :not_found
    end
end
