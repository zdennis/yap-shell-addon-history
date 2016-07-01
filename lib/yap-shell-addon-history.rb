require 'yap/addon'
require 'yap-shell-addon-history/version'

module YapShellAddonHistory
  class Addon < ::Yap::Addon::Base
    self.export_as :history

    attr_reader :file
    attr_reader :position

    def initialize_world(world)
      return unless world.configuration.use_history?
      @world = world

      @file = world.configuration.path_for('history')
      @position = 0

      load_history

      world.func(:history) do |args:, stdin:, stdout:, stderr:|
        history_length = @world.editor.history.length
        first_arg = args.first.to_i
        size = first_arg > 0 ? first_arg + 1 : history_length

        # start from -2 since we don't want to include the current history
        # command being run.
        stdout.puts @world.editor.history[history_length-size..-2]
      end
    end

    def back
      logger.puts "entered"
      current_position = @world.editor.line.text_up_to_position
      found_text = @world.history.find_match_backward(@world.editor.line.text_up_to_position)
      if found_text
        logger.puts "match found: #{found_text.inspect}"
        @world.editor.overwrite_line found_text, position: :preserve
      else
        logger.puts "no match found"
      end
    end

    def forward
      logger.puts "entered"
      current_position = @world.editor.line.text_up_to_position
      found_text = @world.history.find_match_forward(@world.editor.line.text_up_to_position)
      if found_text
        logger.puts "match found: #{found_text.inspect}"
        @world.editor.overwrite_line found_text, position: :preserve
      else
        logger.puts "no match found"
      end
    end

    def save
      logger.puts "saving history file=#{file.inspect}"
      File.open(file, "a") do |file|
        # Don't write the YAML header because we're going to append to the
        # history file, not overwrite. YAML works fine without it.
        unwritten_history = @world.editor.history.to_a[@position..-1]
        if unwritten_history.any?
          contents = unwritten_history
            .each_with_object([]) { |line, arr| arr << line unless line == arr.last  }
            .map { |str| str.respond_to?(:without_ansi) ? str.without_ansi : str }
            .to_yaml
            .gsub(/^---.*?^/m, '')
          file.write contents
        end
      end
    end

    private

    def load_history
      logger.puts "loading history file=#{file.inspect}"
      at_exit { save }

      if File.exists?(file) && File.readable?(file)
        history = YAML.load_file(file) || []

        # History starts at the end of the history loaded from file.
        @position = history.length

        # Rely on the builtin history for now.
        @world.editor.history.replace(history)
      end
    end
  end
end
