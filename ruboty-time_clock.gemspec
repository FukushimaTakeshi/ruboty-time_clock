
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "ruboty/time_clock/version"

Gem::Specification.new do |spec|
  spec.name          = "ruboty-time_clock"
  spec.version       = Ruboty::TimeClock::VERSION
  spec.authors       = ["Fukushima Takeshi"]
  spec.email         = ["whippet.818@gmail.com"]

  spec.summary       = "Ruboty Handler"
  spec.description   = "Ruboty Handler"
  spec.homepage      = "https://github.com/FukushimaTakeshi/ruboty-time_clock"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "ruboty"

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
