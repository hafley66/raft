class ::Dsl::Trap::Printer::Children
  Print = ::Dsl::Trap::Print

  def self.call(inspector)

    o = inspector.options
    calls = inspector.calls

    if !(o.any? Print::DIRECTION)
      o = o | Print::VERTICAL
    end

    if(o.VERTICAL?)
      joiner = "\n#{Print::SOFT_TAB}"
      pre = joiner
      post = "\n"
    end
    if(o.HORIZONTAL?)
      pre = ' '
      joiner = "; "
      post = joiner
    end

    if(o.ARGUMENT_TRUNCATE?)
      calls = readlines(calls)
    end

    lines = calls.map do |c|
      output = inspector.print(c)
      splat = output.split("\n")
      splat.join(joiner)
    end

    pre + (lines).join(joiner) + post
  end

  def self.readlines(calls)
    if(!calls.empty?)
      if(calls.length == 1)
        calls
      else
        medas = calls.map(&:meda)
        flattened_trap_args = medas.flat_map(&:args).select do |arg|
          arg && (arg.is_a? ::Dsl::Trap)
        end
        trap_arg_medas = flattened_trap_args.map(&:meda)
        all = (medas + trap_arg_medas)
        by_ids = all.map do |m|
          [m.id, m]
        end.to_h
        top_level_call_medas = by_ids.values_at(*(medas.map(&:id) - trap_arg_medas.map(&:id)))
        top_level_call_medas.map(&:this)
      end
    end
  end
end