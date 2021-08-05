class TransactionWorker
  include Sidekiq::Worker

  def perform
    TxtTransactionService.new().generate_txt
  end
end
