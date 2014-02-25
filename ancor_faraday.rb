require "faraday"
require "singleton"
require "json"

class AncorFaraday
  include Singleton

  def initialize
    @connect = Faraday.new(:url => 'http://localhost:3000/v1/') do |faraday|
      faraday.request  :url_encoded             # form-encode POST params
      faraday.response :logger                 # log requests to STDOUT
      faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
    end
  end

  def get_version
    sr_get ''
  end

  def commit(slug)
    request_body = { commit: true } 
    sr_put "environments/#{slug}", 'application/json', request_body.to_json
  end

  def plan(slug, path_to_file)
    arml_spec = IO.read path_to_file
    sr_post "environments/#{slug}/plan", 'application/yaml', arml_spec
  end

  def list_goals
    sr_get 'goals'
  end

  def list_envs
    sr_get 'environments'
  end

  def list_roles
    sr_get 'roles'
  end

  def list_tasks
    sr_get 'tasks'
  end

  def list_instances
    sr_get 'instances'
  end

  def add_instance(role_slug)
    request_body = { role: role_slug }
    sr_post 'instances', 'application/json', request_body.to_json
  end

  def remove_instance(old_id)
    @connect.delete "instances/#{old_id}"
  end

  def replace_instance(old_id)
    request_body = { replace: true }
    sr_post "instances/#{old_id}", 'application/json', request_body.to_json
  end

  def add_env(slug)
    request_body = { slug: slug }
    sr_post 'environments', 'application/json', request_body.to_json
  end

   def remove_env(slug)
    @connect.delete "environments/#{slug}"
  end

  # Helpers
  # Sends a GET request and stores the response
  def sr_get(url)
    response =  @connect.get url
  end

  # Sends a POST request and stores the response
  def sr_post(url, content_type, body)
    response = @connect.post do |req|
     req.url url
     req.headers['Content-Type'] = content_type
     req.body = body
    end
  end

  # Sends a PUT request and stores the response
  def sr_put(url, content_type, body)
    response = @connect.put do |req|
     req.url url
     req.headers['Content-Type'] = content_type
     req.body = body
    end
  end
end
