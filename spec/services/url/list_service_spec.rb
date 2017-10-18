require_relative './../../spec_helper.rb'

describe UrlModule::ListService do
  before do
    @company = create(:company)
  end

  describe '#call' do
    it "with list_links command: With zero links added, return message: couldn't find any entries" do
      @listService = UrlModule::ListService.new({}, 'list_links')

      response = @listService.call()
      expect(response).to match("Nada encontrado")
    end

    it "with list_links command: With two links, find url in response" do
      @listService = UrlModule::ListService.new({}, 'list_links')

      url1 = create(:url, company: @company)
      url2 = create(:url, company: @company)

      response = @listService.call()

      expect(response).to match(url1.pathurl)
      expect(response).to match(url2.pathurl)
    end

    it "with search_links command: With empty query, return message: couldn't find" do
      @listService = UrlModule::ListService.new({'query' => ''}, 'search_links')

      response = @listService.call()
      expect(response).to match("Nada encontrado")
    end

    it "with search_links command: With valid query, find pathurl in response" do
      url = create(:url, company: @company)

      @listService = UrlModule::ListService.new({'query' => url.pathurl[7..13]}, 'search_links')

      response = @listService.call()
      expect(response).to match(url.pathurl)

    end

    it "with search_links_by_hashtag command: With invalid hashtag, rreturn message: couldn't find" do
      @listService = UrlModule::ListService.new({'query' => ''}, 'search_links_by_hashtag')

      response = @listService.call()
      expect(response).to match("Nada encontrado")
    end

    it "with search_links_by_hashtag command: With valid hashtag, find pathurl in response" do
      url = create(:url, company: @company)
      hashtag = create(:hashtag, company: @company)
      create(:url_hashtag, url: url, hashtag: hashtag)

      @listService = UrlModule::ListService.new({'query' => hashtag.name}, 'search_links_by_hashtag')

      response = @listService.call()
      expect(response).to match(url.pathurl)
    end
  end
end
