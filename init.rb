module Pepe
  def self.included(controller)
    controller.after_filter :inject_layout_assets
  end

  def inject_layout_assets
    layout.inject!
  end
  
  def layout
    @layout ||= Layout::Base.new(self, @template)
  end
end

ActionController::Base.send(:include, Pepe)

ActionView::Base.class_eval <<-EOS
  def layout
    @controller.layout
  end
EOS
