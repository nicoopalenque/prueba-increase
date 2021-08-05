class SaveData
  def initialize; end

  def save_data(data)
    f = File.open('app/temp/transactions.json', mode: 'w')
    f.puts data.to_json
    f.close
  end
end