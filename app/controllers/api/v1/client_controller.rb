class Api::V1::ClientController < ApplicationController
  require 'json'

  # Show transaction by client
  # params[:id] should be header id
  def show
    c = TxtTransactionService.new.get_client(params[:id])
    if c.body.length > 30
      client = JSON.parse(c.body)
      render json: ClientSerializer.new.serialize_to_json(client)
    else
      render json: response_error, status: :not_found
    end
  end

  private

  def response_error
    { error: 'Could not get data from server' }
  end
end
