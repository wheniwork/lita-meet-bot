Gem::Specification.new do |spec|
  spec.name          = "lita-meet"
  spec.version       = "0.1.0"
  spec.authors       = ["Richard Genthner"]
  spec.email         = ["richard.genthner@wheniwork.com"]
  spec.description   = "Simple Standup meeting bot handler that allows for http api tirggers and searching"
  spec.summary       = "Simple Standup meeting bot"
  spec.homepage      = "https://github.com/wheniwork/lita-meet-bot"
  spec.license       = "MIT"
  spec.metadata      = { "lita_plugin_type" => "handler" }

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "lita", ">= 4.7"
  spec.add_runtime_dependency "json", ">=1.8.1"
  
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "pry-byebug"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rack-test"
  spec.add_development_dependency "rspec", ">= 3.0.0"
end
