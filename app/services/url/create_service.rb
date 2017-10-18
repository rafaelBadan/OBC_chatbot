module UrlModule
  class CreateService
    def initialize(params)
      # TODO: identify origin and set company
      @company = Company.last
      @pathurl = params["pathurl"]
      @hashtags = params["hashtags"]
    end

    def call

      return 'Hashtag Obrigatória' if @hashtags == nil || @hashtags == ""

      begin
        Url.transaction do
          url = Url.create(pathurl: @pathurl, company: @company)
          @hashtags.split(/[\s,]+/).each do |hashtag|
            url.hashtags << Hashtag.create(name: hashtag)
          end
        end
        "Criado com sucesso"
      rescue
        "Problemas na criação"
      end
    end
  end
end
