
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "elastic_notifier/version"

Gem::Specification.new do |spec|
  spec.name          = "elastic_notifier"
  spec.version       = ElasticNotifier::VERSION
  spec.authors       = ["Fabio Pitino"]
  spec.email         = ["pitinofabio@gmail.com"]

  spec.summary       = %q{ElasticSearch error notifier}
  spec.description   = %q{Send errors to ElasticSearch }
  spec.homepage      = "https://github.com/hspazio/elastic_notifier"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "vcr", "~> 3.0"
  spec.add_development_dependency "webmock", "~> 3.0"
  spec.add_development_dependency "simplecov", "~> 0.15"
  spec.add_dependency "elasticsearch-persistence", "~> 5.0"
  spec.add_dependency "typhoeus", "~> 1.3"
end
