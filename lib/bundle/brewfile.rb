# frozen_string_literal: true

module Bundle
  module Brewfile
    module_function

    def path
      if ARGV.include?("--global")
        Pathname.new("#{ENV["HOME"]}/.Brewfile")
      else
        filename = ARGV.value("file")
        if filename == "-"
          filename = if ARGV.include?("dump")
            "/dev/stdout"
          else
            "/dev/stdin"
          end
        end
        filename ||= "Brewfile"
        Pathname.new(filename).expand_path(Dir.pwd)
      end
    end

    def read
      Brewfile.path.read
    rescue Errno::ENOENT
      raise "No Brewfile found"
    end
  end
end
