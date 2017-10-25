require_relative './../../spec_helper.rb'

describe UrlModule::CreateService do
  before do
    @company = create(:company)

    @url = FFaker::Internet.http_url
    @hashtags = "#{FFaker::Lorem.word}, #{FFaker::Lorem.word}"
  end

  describe '#call' do
    it "Without hashtag params, will receive a error" do
      @createService = UrlModule::CreateService.new({"pathurl" => @url})

      response = @createService.call()
      expect(response).to match("Hashtag Obrigatória")
    end

    it "With valid params, receive success message" do
      @createService = UrlModule::CreateService.new({"pathurl" => @url, "hashtags" => @hashtags})

      response = @createService.call()
      expect(response).to match("Criado com sucesso")
    end

    it "With valid params, find aggregated url in database" do
      @createService = UrlModule::CreateService.new({"pathurl" => @url, "hashtags" => @hashtags})

      response = @createService.call()
      expect(Url.last.pathurl).to match(@url)
    end

    it "With valid params, hashtags are created" do
      @createService = UrlModule::CreateService.new({"pathurl" => @url, "hashtags" => @hashtags})

      response = @createService.call()
      expect(@hashtags.split(/[\s,]+/).first).to match(Hashtag.first.name)
      expect(@hashtags.split(/[\s,]+/).last).to match(Hashtag.last.name)
    end
  end
end
