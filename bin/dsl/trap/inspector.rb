class ::Dsl::Trap::Inspector
  Print = ::Dsl::Trap::Print

  delegate :id, :calls, :args, :block, :name, :parents, :eager, to: :'@trap.meda'
  attr_accessor :options
  attr_reader :trap


  def initialize(trp, opts = nil)
    @trap = trp
    self.options = opts
  end

  def call(opts= self.options)
    inspect(opts)
  end

  def my_ancestor?(other)
    !parents.select{|p| p.Equal? other}.empty?
  end

  def my_parent?(node)
    p = parents.last
    if p
      p.Equal?(node)
    end
  end

  def is_self?(other)
    @trap.Equal?(other)
  end

  def options=(opts = self.options)
    @options = opts || @options || Print::DEFAULT
  end

  def inspect(options=self.options)
    self.options = options
    "#{parents.empty? ? "\n": ""}#{inspect_name}#{inspect_arguments}#{inspect_children}"
  end

  def inspect_name
    name ? "#{name}" : ''
  end

  def inspect_children
    if(!calls.blank?)
      "{#{print_children}}"
    end
  end

  def inspect_arguments
    if(!args.blank?)
      printed = print_arguments
      if(options.parens?)
        "( #{printed} )"
      else
        " #{printed} "
      end
    elsif name
      " "
    end
  end

  def print_trap(c)
    o = options
    if(o.THIS? && (is_self? c))
      'SELF'
    elsif(o.PARENT? && (my_parent? c))
      'PARENT'
    elsif(o.ANCESTORS? && (my_ancestor? c))
      'ANCESTOR'
    else
      c.inspect(o)
    end
  end

  def print(c)
    if c.is_a? ::Dsl::Trap
      print_trap(c)
    else
      "#{c.inspect}"
    end
  end 

  def print_children
    ::Dsl::Trap::Printer::Children.call(self)
  end

  def print_arguments
    lines = args.map(&(method(:print)))
    lines.join(", ")
  end

end