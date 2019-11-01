.PHONY: build docs

config:
	bundle exec ruby ./scripts/generate_config.rb $(environment)

open: config
	open client-ios.xcworkspace

install:
	bundle install
	bundle exec pod install

lint:
	bundle exec rubocop
	./Pods/SwiftLint/swiftlint lint

lintfix:
	./Pods/SwiftLint/swiftlint autocorrect
	./Pods/SwiftFormat/CommandLineTool/swiftformat .
