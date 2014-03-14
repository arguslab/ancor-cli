module Ancor
  module CLI
    class Goal < Base
      desc 'list', 'Lists all goals'
      def list
        parsed = JSON.parse(connection.list_goals.body)
        Formatador.display_table(parsed, ['id', 'slug', 'name'])
      end
    end # Goal
  end # CLI
end
