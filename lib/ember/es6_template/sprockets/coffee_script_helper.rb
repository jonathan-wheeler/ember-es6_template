module Ember
  module ES6Template
    module CoffeeScriptHelper
      def call(input)
        data = input[:data]
        filename = input[:filename]

        result = input[:cache].fetch(_cache_key + [filename, data]) do
          if es6?(filename)
            transform(
              Sprockets::Autoload::CoffeeScript.compile(data, bare: true),
              input
            )
          else
            code = Sprockets::Autoload::CoffeeScript.compile(data, bare: false)

            {'code' => code}
          end
        end

        result['code']
      end

      private

      def _cache_key
        [
          self.class.name,
          VERSION,
          Babel::Transpiler.version,
          Babel::Transpiler.source_version,
          Sprockets::Autoload::CoffeeScript.version
        ]
      end

      def es6?(filename)
        base_name = File.basename(filename)
        return false if base_name.match?('js.coffee')
        base_name.match?('.coffee')
      end
    end
  end
end
