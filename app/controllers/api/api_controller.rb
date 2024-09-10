module Api
  class ApiController < ActionController::API
    before_action :check_format
    
    def check_format
      if request.format.html?
        raise ActionController::RoutingError, 'Not supported format'
      end
    end
  end
end