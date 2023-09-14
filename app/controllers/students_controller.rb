class StudentsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_record_not_found
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity

    def index
        render json: Student.all, status: :ok
    end

    def show
        student = find_student
        render json: student, status: :ok
    end

    def create
        student = Student.create!(student_params)
        render json: student, status: :created
    end

    def update
        student = find_student
        student.update!(student_params)
        student.save!
        render json: student, status: :accepted
    end

    def destroy
        student = find_student
        student.destroy!
        head :no_content
    end

    private

    def student_params
        params.permit(:name, :major, :age, :Instructor_id)
    end

    def find_student
        student = Student.find_by(id: params[:id])
    end

    def render_unprocessable_entity(invalid)
        render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
    end

    def render_record_not_found
        render json: {error: "Instructor not found" }, status: :not_found
    end

end
