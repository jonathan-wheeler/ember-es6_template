module Ember
  module ES6Template
    class Config
      attr_accessor :module_prefix, :unnest_app_dir
      attr_reader :prefix_dirs, :prefix_files

      def initialize
        @unnest_app_dir = true
      end

      def prefix_dirs=(dirs)
        @prefix_pattern = nil

        @prefix_dirs = dirs
      end

      def prefix_files=(files)
        @prefix_pattern = nil

        @prefix_files = files
      end

      def prefix_pattern
        @prefix_pattern ||= begin
          patterns = []
          patterns += Array(prefix_dirs).map {|dir| Regexp.new("^#{dir}/") }
          patterns += Array(prefix_files).map {|file| Regexp.new("^#{file}$") }

          patterns.empty? ? // : Regexp.union(patterns)
        end
      end

      def to_hash
        {
          module_prefix: module_prefix,
          prefix_files: prefix_files,
          prefix_dirs: prefix_dirs,
          unnest_app_dir: unnest_app_dir
        }
      end
    end
  end
end
