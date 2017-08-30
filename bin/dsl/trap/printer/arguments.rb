class ::Dsl::Trap::Printer::Arguments
  Print = ::Dsl::Trap::Print

  def self.call(inspector)

    o = inspector.options
    args = inspector.args + []

    if(o =~ Print::ARGUMENT_TRUNCATE)

    end


    lines = calls.map do |c|
      output = inspector.print(c)
      splat = output.split("\n")
      splat.join(joiner)
    end

    pre + (lines).join(joiner) + post
  end

  def self.is_terminal(call)
    call.meda.args.empty?
  end

  def self.readline(args)
    
  end

end
