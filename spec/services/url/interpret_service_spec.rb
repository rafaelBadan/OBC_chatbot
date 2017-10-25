require_relative './../../spec_helper.rb'

describe UrlModule::InterpretService do
  before :each do
    @company = create(:company)
  end

  describe '#list_links' do
    it "With zero urls, return don't find message" do
      response = UrlModule::InterpretService.call('list_links', {})
      expect(response).to match("Nada encontrado")
    end

    it "With two urls, find pathurl in response" do
      url1 = create(:url, company: @company)
      url2 = create(:url, company: @company)

      response = UrlModule::InterpretService.call('list_links', {})

      expect(response).to match(url1.pathurl)
      expect(response).to match(url2.pathurl)

    end
  end

  describe '#search by hashtag' do
    it "With invalid hashtag, return don't find message" do
      response = UrlModule::InterpretService.call('search_links_by_hashtag', {"query": ''})
      expect(response).to match("Nada encontrado")
    end

    it "With valid hashtag, find url response" do
      url = create(:url, company: @company)
      hashtag = create(:hashtag, company: @company)
      create(:url_hashtag, url: url, hashtag: hashtag)

      response = UrlModule::InterpretService.call('search_links_by_hashtag', {"query" => hashtag.name})

      expect(response).to match(url.pathurl)
    end
  end

  describe '#create' do
    before do
      @url = FFaker::Internet.http_url
      @hashtags = "#{FFaker::Lorem.word}, #{FFaker::Lorem.word}"
    end

    it "Without hashtag params, receive a error" do
      response = UrlModule::InterpretService.call('create', {"pathurl" => @url})
      expect(response).to match("Hashtag Obrigatória")
    end

    it "With valid params, receive success message" do
      response = UrlModule::InterpretService.call('create', {"pathurl" => @url, "hashtags" => @hashtags})
      expect(response).to match("Criado com sucesso")
    end

    it "With valid params, find aggregated url in database" do
      response = UrlModule::InterpretService.call('create', {"pathurl" => @url, "hashtags" => @hashtags})
      expect(Url.last.pathurl).to match(@url)
    end

    it "With valid params, hashtags are created" do
      response = UrlModule::InterpretService.call('create', {"pathurl" => @url, "hashtags" => @hashtags})
      expect(@hashtags.split(/[\s,]+/).first).to match(Hashtag.first.name)
      expect(@hashtags.split(/[\s,]+/).last).to match(Hashtag.last.name)
    end
  end

  describe '#remove' do
    it "With valid ID, remove Url" do
      url = create(:url, company: @company)
      response = UrlModule::InterpretService.call('remove', {"id" => url.id})
      expect(response).to match("Link deletado com sucesso")
    end

    it "With invalid ID, receive error message" do
      response = UrlModule::InterpretService.call('remove', {"id" => rand(1..9999)})
      expect(response).to match("Link inválido, verifique o Id")
    end
  end
end
