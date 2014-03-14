require 'faraday'
require 'formatador'
require 'json'
require 'thor'

require 'ancor/cli/version'

require 'ancor/cli/base'
require 'ancor/cli/client'
require 'ancor/cli/environment'
require 'ancor/cli/goal'
require 'ancor/cli/instance'
require 'ancor/cli/role'
require 'ancor/cli/task'

require 'ancor/cli/front'

module Ancor
  module CLI
    def self.start
      Front.start(ARGV)
    end
  end
end
