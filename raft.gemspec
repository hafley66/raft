# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|

  gem = ->(name, *reqs) {
    spec.add_dependency name, *reqs
  }
  dev = ->(name, *reqs) {
    spec.add_development_dependency name, *reqs
  }
  spec.name          = "raft"
  spec.version       = "0.1.0"
  spec.authors       = ["Chris Hafley"]
  spec.email         = ["dch66@case.edu"]

  spec.summary       = %q{Ruby Automatic Functional Typing for easier dev documentations and type checking}
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files = `git ls-files -z`.split("\x0").reject { |f|
    f.match(%r{^(test|spec|features|dev\.Dockerfile|docker-compose.yml|Dockerfile)/})
  }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]


  dev.("bundler", "~> 1.13")
  dev.("rake", "~> 10.0")
  dev.("rspec" ,'~> 3.5')
  dev.('listen', '~> 3.0.5')
  dev.('guard-rspec', '~> 4.6')
  dev.("guard-shell")
  gem.('attr_extras')
end
