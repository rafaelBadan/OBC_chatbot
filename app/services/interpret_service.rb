# TODO: create test for this service and update FAQ and URL tests

class InterpretService
  def self.call action, params
    case action
    when "list", "search", "search_by_hashtag"
      FaqModule::ListService.new(params, action).call()
    when "create_faq"
      FaqModule::CreateService.new(params).call()
    when "remove_faq"
      FaqModule::RemoveService.new(params).call()
    when "list_links", "search_links_by_hashtag"
      UrlModule::ListService.new(params, action).call()
    when "create_link"
      UrlModule::CreateService.new(params).call()
    when "remove_link"
      UrlModule::RemoveService.new(params).call()
    when "help"
      HelpService.call()
    else
      "Não compreendi o seu desejo"
    end
  end
end
