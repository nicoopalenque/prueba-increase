class ClientSerializer < Panko::Serializer
  attributes :email, :first_name, :last_name, :job, :country, :address, :zip_code, :phone
end