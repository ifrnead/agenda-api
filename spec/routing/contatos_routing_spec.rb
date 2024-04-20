require "rails_helper"

RSpec.describe ContatosController, type: :routing do
  describe "roteamento" do
    it "roteia GET /contatos para contatos#index" do
      expect(get: "/contatos").to route_to("contatos#index")
    end

    it "roteia GET /contatos/:id para contatos#show" do
      expect(get: "/contatos/1").to route_to("contatos#show", id: "1")
    end


    it "roteia POST /contatos para contatos#create" do
      expect(post: "/contatos").to route_to("contatos#create")
    end

    it "roteia PUT /contatos/:id para contatos#update" do
      expect(put: "/contatos/1").to route_to("contatos#update", id: "1")
    end

    it "roteia PATCH /contatos/:id para contatos#update" do
      expect(patch: "/contatos/1").to route_to("contatos#update", id: "1")
    end

    it "roteia DELETE /contatos/:id para contatos#destroy" do
      expect(delete: "/contatos/1").to route_to("contatos#destroy", id: "1")
    end
  end
end
