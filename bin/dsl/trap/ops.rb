class ::Dsl::Trap::Ops < ::Dsl::Trap::Base

  def self.define_trap(op)
    ::Dsl::Trap::Rexer.unary_function(op) ? define_unary_trap(op) : define_binary_trap(op)
  end

  def self.define_unary_trap(op)
    display_op = op.to_s.gsub('@', '')
    define_method(op) {
      method_missing(display_op, self)
    }
  end

  def self.define_binary_trap(op)
    display_op = op.to_s.gsub('@', '')
    define_method(op) { |other|
      method_missing(display_op, other)
    }
  end

  def class
    ::Dsl::Trap::Ops
  end

  OPS = [
    :!, :~, :-@, :+@,
    :+, :-, :/, :*, :**, :%,
    :[], :[]=,
    :|, :&, :^, :>>, :<<,
    :=~, :==,  :>, :<,  :<=, :>=, :===,  :<=>, :!=, :!~,
  ]
  OPS.each{ |op| define_trap(op) }
end
