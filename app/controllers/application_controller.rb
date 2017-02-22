class ApplicationController < ActionController::API
 before_action :authenticate_user
 # before_filter :cors_preflight_check
 # after_filter :cors_set_access_control_headers

 # def cors_set_access_control_headers
 #   headers['Access-Control-Allow-Origin'] = '*'
 #   headers['Access-Control-Allow-Methods'] = 'POST, PUT, DELETE, GET, OPTIONS'
 #   headers['Access-Control-Request-Method'] = '*'
 #   headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization'
 #
 # end
 #
 # def cors_preflight_check
 #   if request.method == 'OPTIONS'
 #     headers['Access-Control-Allow-Origin'] = '*'
 #     headers['Access-Control-Allow-Methods'] = 'POST, PUT, DELETE, GET, OPTIONS'
 #     headers['Access-Control-Request-Method'] = '*'
 #     headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization'
 #
 #     render :text => '', :content_type => 'text/plain'
 #   end
 # end

 def authenticate_user
   render json: {error: "unauthorized user!!!"} unless signed_in?
 end

 def signed_in?
   !!current_user
 end

 def current_user
   User.find(Auth.decode(request.env["HTTP_AUTHORIZATION"])["user_id"]) if request.env["HTTP_AUTHORIZATION"].present?
 end


end
