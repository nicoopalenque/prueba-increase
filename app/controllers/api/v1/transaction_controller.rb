class Api::V1::TransactionController < ApplicationController
  
  def index
    generate_txt
    clients = BuildData.new().build
    if clients.length > 0
      SaveData.new().save_data(clients)
      render_paginated clients
    else
      render json: error_response, status: :not_found
    end
  end

  def show
    file = File.open('app/temp/transactions.json', 'r')
    data = JSON.load(file)
    file.close
    client = ResponseTransaction.new().get_clients(data, params[:id])
    if client.present?
      resp = ResponseTransaction.new.parse_transaction_response(client)
      render json: resp
    else
      render json: error_response, status: :not_found
    end
  end

  private

  def error_response
    { error: 'Could not get data from server' }
  end

  def generate_txt
    TxtTransactionService.new().generate_txt
  end

  def response_transaction
    ResponseTransaction.new
  end

end
