class TxtTransactionService
  require 'httparty'

  def initialize()
    @token = 'Bearer 1234567890qwertyuiopasdfghjklzxcvbnm'
    @url = 'https://increase-transactions.herokuapp.com/'
  end

  def get_transaction_txt
    HTTParty.get("#{@url}file.txt", headers: { 'Authorization' => @token })
  end

  def get_client(id)
    HTTParty.get("#{@url}clients/#{id}", headers: { 'Authorization' => @token })
  end

  def generate_txt
    txt = get_transaction_txt
    f = File.open('app/temp/transaction.txt', mode: 'w')
    f.puts txt
    f.close
    txt
  end
end