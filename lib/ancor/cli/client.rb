module Ancor
  module CLI
    class Client
      CONTENT_TYPE_JSON = 'application/json'
      CONTENT_TYPE_YAML = 'application/yaml'

      def initialize(options)
        host = options.fetch(:host)
        port = options.fetch(:port)

        url = "http://#{host}:#{port}/v1/"

        @connection = Faraday.new(url: url) do |faraday|
          faraday.response :logger if options[:debug]
          faraday.adapter Faraday.default_adapter
        end
      end

      def version
        get ''
      end

      def commit(slug)
        request_body = { commit: true }
        put "environments/#{slug}", CONTENT_TYPE_JSON, request_body.to_json
      end

      def plan(slug, arml_spec)
        post "environments/#{slug}/plan", CONTENT_TYPE_YAML, arml_spec
      end

      def list_goals
        get 'goals'
      end

      def list_envs
        get 'environments'
      end

      def list_roles
        get 'roles'
      end

      def list_tasks
        get 'tasks'
      end

      def list_instances
        get 'instances'
      end

      def add_instance(role_slug)
        request_body = { role: role_slug }
        post 'instances', CONTENT_TYPE_JSON, request_body.to_json
      end

      def remove_instance(old_id)
        @connection.delete "instances/#{old_id}"
      end

      def replace_instance(old_id)
        request_body = { replace: true }
        put "instances/#{old_id}", CONTENT_TYPE_JSON, request_body.to_json
      end

      def replace_all_instances(role_slug)
        request_body = { role: role_slug }
        post "instances/#{role_slug}/replace_all", CONTENT_TYPE_JSON, request_body.to_json
      end

      def add_env(slug)
        request_body = { slug: slug }
        post 'environments', CONTENT_TYPE_JSON, request_body.to_json
      end

      def remove_env(slug)
        @connection.delete "environments/#{slug}"
      end

      private

      # @param [String] url
      # @return [Faraday::Response]
      def get(url)
        @connection.get url
      end

      # @param [String] url
      # @param [String] content_type
      # @param [String] body
      # @return [Faraday::Response]
      def post(url, content_type, body)
        @connection.post do |req|
          req.url url
          req.headers['Content-Type'] = content_type
          req.body = body
        end
      end

      def put(url, content_type, body)
        @connection.put do |req|
          req.url url
          req.headers['Content-Type'] = content_type
          req.body = body
        end
      end
    end # Client
  end # CLI
end
