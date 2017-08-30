class ::Dsl::Trap::Base < ::BasicObject
  attr_accessor :meda
  Child = 0
  Self = 1
  Depth = 0
  Breadth = 1

  @@id = 0

  def self.reset_id
    @@id = 0
  end

  def puts(*args)
    ::Object.send(:puts, *args)
  end

  InstanceFields = ::Struct.new(:id, :name, :args, :block, :calls, :parents, :eval_order, :return_as, :this)
  def initialize(name=nil, args=[], block=nil, parents: [], eval_order: Depth, return_as: Child)
    @id = @@id
    @@id += 1
    self.meda = InstanceFields.new(@id, name, args, block, [], parents, eval_order, return_as, self)
  end

  def my_id
    @id
  end

  def return_self
    @meda.return_as = Self
    self
  end

  def return_child
    @meda.return_as = Child
    self
  end

  def return_self?
    @meda.return_as == Self
  end

  def return_child?
    @meda.return_as == Child
  end

  def method_missing(name, *args, &block)
    child = self.class.new(name, args, block,
      parents: @meda.parents + [self],
      eval_order: @meda.eval_order,
      return_as: @meda.return_as
    )
    @meda.calls << child

    target = nil
    if(return_self?)
      target = self
    else
      target = child
    end

    if(@meda.eval_order == Depth && block)
      target.instance_eval(&block)
    end
    target
  end

  def inspect(options=nil)
    inspector(options).call
  end

  def inspector(options = nil)
    ::Dsl::Trap::Inspector.new(self, options)
  end

  def to_s(as_child = false)
    inspect(as_child)
  end

  def is_trap
    true
  end

  def class
    ::Dsl::Trap::Base
  end

  def Equal?(other)
    BasicObject.instance_method(:==).bind(self).call(other)
  end

  def is_a?(klass)
    klass == ::Dsl::Trap::Base || klass == ::Dsl::Trap
  end

end