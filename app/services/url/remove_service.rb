module UrlModule
  class RemoveService
    def initialize(params)
      # TODO: identify origin and set company
      @company = Company.last
      @params = params
      @id = params["id"]
    end

    def call
      url = @company.urls.where(id: @id).last
      return "Link inválido, verifique o Id" if url == nil

      Url.transaction do
        # Deleta as tags associadas que não estejam associadas a outras urls
        url.hashtags.each do |h|
          if h.urls.count <= 1
            h.delete
          end
        end
        url.delete
        "Link deletado com sucesso"
      end
    end
  end
end
