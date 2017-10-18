module UrlModule
  class ListService
    def initialize(params, action)
      # TODO: identify origin and set company
      @company = Company.last
      @action = action
      @query = params["query"]
    end

    def call
      if @action == "search_links"
        urls = Url.search(@query).where(company: @company)
      elsif @action == "search_links_by_hashtag"
        urls = []
        @company.urls.each do |url|
          url.hashtags.each do |hashtag|
            urls << url if hashtag.name == @query
          end
        end
      else
        urls = @company.urls
      end

      response = "*Links agregados:* \n\n"
      urls.each do |u|
        response += "*#{u.id}* - "
        response += "*#{u.pathurl}*\n"
        f.hashtags.each do |h|
          response += "_##{h.name}_ "
        end
        response += "\n\n"
      end
      (urls.count > 0)? response : "Nada encontrado"
    end
  end
end
