module SubstAttr
  def self.activate(target_class=nil)
    target_class ||= Object

    return if target_class.ancestors.include? SubstAttr::Macro

    target_class.extend SubstAttr::Macro
  end
end
