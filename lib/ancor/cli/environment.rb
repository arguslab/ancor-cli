module Ancor
  module CLI
    class Environment < Base
      desc 'list', 'Lists all environments'
      def list
        parsed = JSON.parse(connection.list_envs.body)
        Formatador.display_table(parsed, ['id', 'slug', 'name','locked'])
      end

      desc 'add <environment slug>', 'Adds an environment with the given name'
      def add(slug)
        connection.add_env(slug)
      end

      desc 'remove <environment slug>', 'Removes an environment'
      def remove(slug)
        connection.remove_env(slug)
      end

      option :environment, default: 'production'
      desc 'plan <path to arml file>', 'Imports an ARML specification and plans a deployment'
      def plan(path_to_file)
        begin
          spec = File.read(path_to_file)
          connection.plan(options[:environment], spec)
        rescue IOError, Errno::ENOENT
          puts 'Could not read specification, make sure file path is correct'
        end
      end

      option :environment, default: 'production'
      desc 'commit', 'Commits any planned deployments for the given environment'
      def commit
        connection.commit(options[:environment])
      end
    end # Environment
  end # CLI
end
