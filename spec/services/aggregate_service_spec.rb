require_relative './../spec_helper.rb'

describe AggregateService do
  before do
    @url = FFaker::Internet.http_url
    @hashtags = "#{FFaker::Lorem.word}, #{FFaker::Lorem.word}"
  end

  describe '#call' do
    it "Without hashtag params, will receive a error" do
      @aggregateService = AggregateService.new({"pathurl" => @url})

      response = @aggregateService.call()
      expect(response).to match("Hashtag Obrigatória")
    end

    it "With valid params, receive success message" do
      @aggregateService = AggregateService.new({"pathurl" => @url, "hashtags" => @hashtag})

      response = @aggregateService.call()
      expect(response).to match("Criado com sucesso")
    end

    it "With valid params, find aggregated url in database" do
      @aggregateService = AggregateService.new({"pathurl" => @url, "hashtags" => @hashtags})

      response = @aggregateService.call()
      expect(Url.last.url).to match(@url)
      expect(Url.last.hashtags).to match(@hashtags)
    end

    it "With valid params, hashtags are created" do
      @aggregateService = AAggregateService.new({"pathurl" => @url, "hashtags" => @hashtags})

      response = @aggregateService.call()
      expect(@hashtags.split(/[\s,]+/).first).to match(Hashtag.first.name)
      expect(@hashtags.split(/[\s,]+/).last).to match(Hashtag.last.name)
    end
  end
end
