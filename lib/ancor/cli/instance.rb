module Ancor
  module CLI
    class Instance < Base
      desc 'list', 'Lists all instances'
      def list
        parsed = JSON.parse(connection.list_instances.body)
        parsed.each do |instance|
          instance['internal_ip'] = instance['interfaces'].map { |interface|
            interface['ip_address']
          }.join(', ')
          if instance['public_ip']
            instance['public_ip'] = instance['public_ip']['ip_address']
          end
        end
        Formatador.display_table(parsed, ['id', 'name', 'stage', 'planned_stage', 'internal_ip', 'public_ip'])
      end

      desc 'add <role slug>', 'Adds a new instance with the given role'
      def add(role_slug)
        connection.add_instance(role_slug)
      end

      desc 'remove <instance id>', 'Removes the given instance'
      def remove(old_id)
        connection.remove_instance(old_id)
      end

      desc 'replace <instance id>', 'Replaces the given instance with a new instance of the same role'
      def replace(old_id)
        connection.replace_instance(old_id)
      end

      desc 'replace_all <role slug>', 'Replaces all instances of the given role with new instances'
      def replace_all(role_slug)
        connection.replace_all_instances(role_slug)
      end
    end # Instance
  end # CLI
end
