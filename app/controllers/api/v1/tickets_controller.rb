class Api::V1::TicketsController < ApplicationController
  def create
    run Api::V1::Ticket::Operations::Create do |ctx|
      return render json: TicketBlueprint.render(@model), status: :created
    end

    render json: { errors: @form.errors.full_messages }, status: :unprocessable_entity
  end
end
