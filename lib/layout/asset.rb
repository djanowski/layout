module Layout
  class Asset
    include ActionView::Helpers::TagHelper
    include ActionView::Helpers::AssetTagHelper
    include ERB::Util

    attr_accessor :name

    def initialize(name)
      @name = name.to_s

      yield(self) if block_given?
    end

    def to_s
      name
    end

    def to_html
      raise 'Not implemented.'
    end

    def self.create(name, *args, &block)
      return name if name.kind_of? Asset 

      name = name.to_s

      if name =~ /\.(css|js)$/
        case $1
          when 'css': Stylesheet.new(name, *args, &block)
          when 'js':  Script.new(name, *args, &block)
        end
      else
        raise "#{name}: There's no asset of that type."
      end
    end
  end
end
