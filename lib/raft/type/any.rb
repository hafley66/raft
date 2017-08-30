class Raft::Type::Any
  attr_reader :fields

  def initialize(fields = {})
    @fields = fields || {}
  end

  def add_field(name, type)

  end


  def member?(instance)

  end

  def of_type

  end

  def respond_to?(name)
    if(fields.key? name.to_sym)

    end
  end

end