module Layout
  class Script < Asset
    def to_html
      javascript_include_tag(name)
    end
  end
end
