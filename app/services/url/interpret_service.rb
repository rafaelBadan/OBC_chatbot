module UrlModule
  class InterpretService
    def self.call action, params
      case action
      when "list_links", "search_links_by_hashtag"
        UrlModule::ListService.new(params, action).call()
      when "create"
        UrlModule::CreateService.new(params).call()
      when "remove"
        UrlModule::RemoveService.new(params).call()
      when "help"
        HelpService.call()
      else
        "Não compreendi o seu desejo"
      end
    end
  end
end
