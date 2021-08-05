class BuildData

  def initialize; end

  def build
    band = false
    clients = []
    transactions = []
    discounts = []
    client = {}
    header = {}
    transaction = {}
    discount = {}
    footer = {}
    content = File.read('app/temp/transaction.txt')
    lines = content.split("\n")
    lines.each do |line|
      if line[0] == '1'
        band = true
        header['id'] = line[1..32]
        header['currency'] = line[35..38]
        header['total_amount'] = line[39..51]
        header['total_discount'] = line[52..64]
        header['total_with_discount'] = line[65..77]
       
      end
      if line[0] == '2'
        transaction['id'] = line[1..32]
        transaction['amount'] = line[33..45]
        transaction['type'] = line[51]
        transactions << transaction
        transaction = {}
      end
      if line[0] == '3'
        discount['id'] = line[1..32]
        discount['amount'] = line[33..45]
        discount['type'] = line[49]
        discounts << discount
        discount = {}
      end
      if line[0] == '4'
        footer['payment_date'] = line[16..23]
        footer['client'] = line[24..56]
        band = false
      end
      client['header'] = header
      client['transaction'] = transactions
      client['discount'] = discounts
      client['footer'] = footer
      if !band
        clients << client
        client = {}
        header = {}
        transaction = {}
        discount = {}
        footer = {}
        transactions = []
        discounts = []
      end
    end
    clients
  end
end