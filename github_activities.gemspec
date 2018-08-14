
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "github_activities/version"

Gem::Specification.new do |spec|
  spec.name          = "github_activities"
  spec.version       = GithubActivities::VERSION
  spec.authors       = ["nyaahara"]
  spec.email         = ["d.niihara@gmail.com"]

  spec.summary       = %q{github_activities supports to know activities on Github.com.}
  spec.homepage      = "https://github.com/nyaahara/github_activities"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_dependency "thor"
  spec.add_dependency "octokit"
end
