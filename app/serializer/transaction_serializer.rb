class TansactionSerializer < Panko::Serializer
  attributes :header
  
  def header
    {
      currency: object.currency == '000' ? 'ARS' : 'USD'

    }
  end
end