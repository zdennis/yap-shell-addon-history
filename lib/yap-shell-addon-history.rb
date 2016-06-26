require 'yap/addon'

module YapShellAddonHistory
  class Addon < ::Yap::Addon::Base
    self.export_as :history

    def initialize_world(world)
      @world = world

      # Initialize your addon here. A few helpful things:
      #
      # @world is an Yap::World instance and it brings together
      #   all the things you may want to interact with. E.g.
      #   aliases, builtins, env, shell_commands, key bindings,
      #   editor, prompt, etc.
      #
      # For more information see:
      #    https://github.com/zdennis/yap-shell/wiki/Addons
    end
  end
end