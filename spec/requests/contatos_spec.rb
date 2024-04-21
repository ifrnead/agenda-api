require 'rails_helper'

RSpec.describe "/contatos", type: :request do
  describe "GET /contatos" do
    it "responde com HTTP status 200 (OK)" do
      create(:contato)
      get contatos_url, as: :json
      expect(response).to be_successful
    end
  end

  describe "GET /contatos/:id" do
    it "responde com HTTP status 200 (OK)" do
      contato = create(:contato)
      get contato_url(contato), as: :json
      expect(response).to be_successful
    end
  end

  describe "POST /contatos" do
    context "com parâmetros válidos" do
      it "cria um novo contato" do
        expect {
          post '/contatos', params: { contato: build(:contato) }, as: :json
        }.to change(Contato, :count).by(1)
      end

      it "responde com o JSON do novo contato" do
        post '/contatos', params: { contato: build(:contato) }, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "com parâmetros inválidos" do
      it "não cria um novo contato" do
        expect {
          post '/contatos', params: { contato: build(:contato, nome: '') }, as: :json
        }.to change(Contato, :count).by(0)
      end

      it "responde com HTTP status 422 (Unprocessable entity)" do
        post '/contatos', params: { contato: build(:contato, nome: '') }, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  describe "PATCH /contatos/:id" do
    context "com parâmetros válidos" do
      it "atualiza o contato" do
        contato = create(:contato)
        patch contato_url(contato), params: { contato: {nome: 'Novo nome', telefone: 'novo-telefone', email: 'novo-email'}}, as: :json
        contato.reload

        expect(contato.nome).to eq('Novo nome')
        expect(contato.telefone).to eq('novo-telefone')
        expect(contato.email).to eq('novo-email')
      end

      it "responde com o JSON do novo contato" do
        contato = create(:contato)
        patch contato_url(contato), params: { contato: {nome: 'Novo nome', telefone: 'novo-telefone', email: 'novo-email'}}, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including("application/json"))

        resp = JSON.parse(response.body)
        expect(resp['nome']).to eq('Novo nome')
        expect(resp['telefone']).to eq('novo-telefone')
        expect(resp['email']).to eq('novo-email')
      end
    end

    context "com parâmetros inválidos" do
      it "responde com HTTP status 422 (Unprocessable entity)" do
        contato = create(:contato)
        patch contato_url(contato), params: { contato: build(:contato, nome: '') }, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  describe "DELETE /contato/:id" do
    context "quando o contato existe" do
      it "destroys the requested contato" do
        contato = create(:contato)
        expect {
          delete contato_url(contato), as: :json
        }.to change(Contato, :count).by(-1)
      end
    end

    context "quando o contato não existe" do
      it "responde com 404 (Not found)" do
        patch contato_url(id: -1), as: :json
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
