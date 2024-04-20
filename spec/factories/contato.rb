Faker::Config.locale = 'pt-BR'

FactoryBot.define do
  factory :contato do
    nome { Faker::Name.name }
    telefone { Faker::PhoneNumber.phone_number_with_country_code }
    email { Faker::Internet.email }
  end
end