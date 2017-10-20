require_relative './../../spec_helper.rb'

describe UrlModule::RemoveService do
  before do
    @company = create(:company)
  end

  describe '#call' do
    it "With valid ID, remove Link" do
      url = create(:url, company: @company)
      @removeService = UrlModule::RemoveService.new({"id" => url.id})
      response = @removeService.call()

      expect(response).to match("Link deletado com sucesso")
    end

    it "With invalid ID, receive error message" do
      @removeService = UrlModule::RemoveService.new({"id" => rand(1..9999)})
      response = @removeService.call()

      expect(response).to match("Link inválido, verifique o Id")
    end

    it "With valid ID, remove Url from database" do
      url = create(:url, company: @company)
      @removeService = UrlModule::RemoveService.new({"id" => url.id})

      expect(Url.all.count).to eq(1)
      response = @removeService.call()
      expect(Url.all.count).to eq(0)
    end
  end
end
