module Layout
  class Stylesheet < Asset
    attr_accessor :condition

    def to_html
      html = stylesheet_link_tag(name)
      html = "<!--[if #{html_condition}]>#{html}<![endif]-->" unless condition.blank?
      html
    end

    protected
      def html_condition
        return nil if condition.blank?
        condition.sub('<', 'lt').sub('>', 'gt').sub('=', 'e')
      end
  end
end
