module SubstAttr
  module Macro
    def subst_attr_macro(attr_name, interface=nil, record: nil)
      SubstAttr::Attribute.define(self, attr_name, interface, record)
    end
    alias :subst_attr :subst_attr_macro
  end
end
