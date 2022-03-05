require_relative 'lib/klaytn/version'

Gem::Specification.new do |spec|
  spec.name          = "klaytn"
  spec.version       = Klaytn::VERSION
  spec.authors       = ["Ryan Kulp", "Ooju"]
  spec.email         = ["launch@ooju.xyz"]

  spec.summary       = "Klaytn is a Ruby wrapper for the Klaytn blockchain."
  spec.description   = "Interact with transactions, smart contracts, and NFTs on the Klaytn blockchain in pure Ruby."
  spec.homepage      = "https://github.com/OojuTeam/klaytn-ruby"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  # spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/OojuTeam/klaytn-ruby"
  spec.metadata["changelog_uri"] = "https://github.com/usefomo/fomo-ruby-sdk/releases"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "rspec", "~> 3.9.1"
  spec.add_development_dependency "httparty", "~> 0.17.0"
  spec.add_development_dependency "ethereum.rb", "~> 2.5"
end
