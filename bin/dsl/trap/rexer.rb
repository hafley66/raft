class ::Dsl::Trap::Rexer < ::Rexer
  from({
    'UNARY_FUNCTION': {
      regex: /^[!~]$|[+-]@$/
    },
    'QUESTION_FUNCTION': {
      regex: /^.+\?$/
    },
    'EXCITED_FUNCTION': {
      regex: /^.+!$/
    },
    'ASSIGNMENT_FUNCTION': {
      regex: /^.+=$/
    },
  })
end