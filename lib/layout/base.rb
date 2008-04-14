module Layout
  class Base
    attr_accessor :assets

    cattr_accessor :default_assets

    def initialize(controller, template)
      @controller, @template = controller, template
    end

    def inject!
      inject_in(@controller.response.body)
    end

    def inject_in(str)
      return if assets.empty?

      html = assets.map {|a| a.to_html }.join("\n")

      str.sub!('</head>', "#{html}\n</head>")
    end

    def <<(asset)
      assets << Asset.create(asset)
    end
    
    def script(name)
      assets << Script.new(name)
    end

    def stylesheet(name, condition = nil)
      s = Stylesheet.new(name)
      s.condition = condition
      assets << s
    end

    def assets
      @assets ||= (default_assets || []).map {|s| Asset.create(s) }
    end

    def self.asset(*args, &block)
      @@default_assets ||= []
      @@default_assets << Asset.create(*args, &block)
    end
  end
end
