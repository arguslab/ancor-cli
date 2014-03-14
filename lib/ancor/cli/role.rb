module Ancor
  module CLI
    class Role < Base
      desc 'list', 'Lists all roles'
      def list
        parsed = JSON.parse(connection.list_roles.body)
        Formatador.display_table(parsed, ['id', 'slug', 'name', 'min', 'max'])
      end
    end # Role
  end # CLI
end
