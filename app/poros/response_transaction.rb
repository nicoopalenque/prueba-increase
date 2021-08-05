class ResponseTransaction
  require 'json'
  def initialize; end

  def get_clients(data, id)
    client = {}
    data.each do |d|
      if d['header']['id'] == id
        client = d
      end
    end
    c = TxtTransactionService.new.get_client(client['footer']['client'])
    if c.body.length > 30
      client['footer']['client'] = JSON.parse(c.body)
      # puts client
      client
    end
  end

  def parse_transaction_response(client)
    resp = {}
    resp['client'] = "#{client['footer']['client']['first_name']} #{client['footer']['client']['last_name']}"
    resp['email'] = client['footer']['client']['email']
    resp['country'] = client['footer']['client']['country'] 
    resp['address'] = client['footer']['client']['address']
    resp['zip_code'] = client['footer']['client']['zip_code']
    resp['phone'] = client['footer']['client']['phone']
    resp['currency'] = client['header']['currency'] == '000' ? 'ARS' : 'USD'
    resp['received'] = "$ #{money_received(client['transaction'])}"
    resp['to_received'] ="$ #{money_to_received(client['transaction'])}"
    resp['total_amount'] = "$ #{client['header']['total_amount'].sub(/^0+/, "")}"
    resp['total_discount'] = "$ #{client['header']['total_discount'].sub(/^0+/, "")}"
    resp['total_with_discount'] = "$ #{client['header']['total_with_discount'].sub(/^0+/, "")}"
    resp['transaction'] = parse_transaction_array(client['transaction'])
    resp['discount'] = parse_discount_array(client['discount'])
    resp
  end

  def money_received(transactions)
    received = 0
    transactions.each do |transaction|
      if transaction['type'].to_i == 1
        received = received + transaction['amount'].to_i
      end
    end
    received
  end

  def money_to_received(transactions)
    received = 0
    transactions.each do |transaction|
      if transaction['type'].to_i == 2
        received = received + transaction['amount'].to_i
      end
    end
    received
  end

  def parse_discount_array(discounts)
    data = {}
    resp = []
    discounts.each do |discount|
      data['amount'] = "$ #{discount['amount'].sub(/^0+/, "")}"
      if discount['type'].to_i == 1
        data['type'] = 'IVA'
      end
      if discount['type'].to_i == 2
        data['type'] = 'Retenciones'
      end
      if discount['type'].to_i == 3
        data['type'] = 'Comisiones'
      end
      if discount['type'].to_i == 4
        data['type'] = 'Costos extra'
      end
      if discount['type'].to_i == 5
        data['type'] = 'Ingresos brutos'
      end
      resp << data
      data = {}
    end
    resp
  end

  def parse_transaction_array(transactions)
    data = {}
    resp = []
    transactions.each do |transaction|
      data['amount'] = "$ #{transaction['amount'].sub(/^0+/, "")}"
      data['type'] = transaction['type'].to_i == 1 ? 'Aprobado' : 'Rechazado'
      resp << data
      data = {}
    end
    resp
  end
end