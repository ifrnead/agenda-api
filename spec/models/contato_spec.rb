require 'rails_helper'

RSpec.describe Contato, type: :model do
  it 'tem o atributo nome' do
    expect(subject.attributes).to include('nome')
  end

  it 'tem o atributo telefone' do
    expect(subject.attributes).to include('telefone')
  end

  it 'tem o atributo email' do
    expect(subject.attributes).to include('email')
  end
end
