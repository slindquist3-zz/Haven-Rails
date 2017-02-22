class ApplicationController < ActionController::API
 before_action :authenticate_user
 before_filter :set_headers

private

def set_headers
  if request.headers["HTTP_ORIGIN"]
  # better way check origin
  # if request.headers["HTTP_ORIGIN"] && /^https?:\/\/(.*)\.some\.site\.com$/i.match(request.headers["HTTP_ORIGIN"])
    headers['Access-Control-Allow-Origin'] = request.headers["HTTP_ORIGIN"]
    headers['Access-Control-Expose-Headers'] = 'ETag'
    headers['Access-Control-Allow-Methods'] = 'GET, POST, PATCH, PUT, DELETE, OPTIONS, HEAD'
    headers['Access-Control-Allow-Headers'] = '*,x-requested-with,Content-Type,If-Modified-Since,If-None-Match,Auth-User-Token'
    headers['Access-Control-Max-Age'] = '86400'
    headers['Access-Control-Allow-Credentials'] = 'true'
    end
  end


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
