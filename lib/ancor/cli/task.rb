module Ancor
  module CLI
    class Task < Base
      desc 'list', 'Lists all tasks'
      def list
        parsed = JSON.parse(connection.list_tasks.body)
        Formatador.display_table(parsed, ['id', 'type', 'state', 'updated_at'])
      end
    end # Task
  end # CLI
end
