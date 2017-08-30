module Raft::Type
end
Dir.glob(File.join(__dir__, 'type', '**', '*.rb'), &method(:require))
