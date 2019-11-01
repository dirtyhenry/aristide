# Aristide

## Installation

This project has 2 mandatory technical stacks:

* **Swift**, for the core app development;
* **Ruby**, for the tooling around it (CocoaPods, Fastlane).

_Swift_ is bundled with [**Xcode**][xcode], and you can manage your _Ruby_ versions with [**rvm**][rvm].

Once both stacks are installed, this command will install dependencies of this
project:

```
make install
```

Before you run the project for the first time, you will have to create your
own `config.yml` file from `config.sample.yml` and run `make config` to
transform this configuration into an `Environment.xcconfig` file that is
expected by Xcode.

## Development

### Environment Management

In order that 1 device can simultaneously have apps targeting several environments, each environment has
its own bundle ID, display name, etc.

These specifics are automated on CI by a build preprocessor that allows custom behaviors, such as:

* removal of some keys (for instance, no `DEBUG_` keys are left when building store apps);
* transformation of values (for instance, the display name of an app).

If you need to target another environment than your developer's environment,
please update `config.yml` accordingly and run `make config` again.

**⚠️ Please don't create new project configurations within Xcode!** We want to
keep things separate between pure **build** configurations (ie preprocessor
macros, Swift optimizations, etc.) and **environment** configurations. At the
price of an initial inconvenience, it will eventually pay off as new Xcode,
Swift and iOS versions appear.

### Dependency Management

We use [**CocoaPods**][cocoapods] to manage our dependencies.

As such, open the project using the `.xcworkspace` file, not the `.xcodeproj`.
Or be lazy and use `make open`.

### Visual Regression Testing

`make test-snapshots` will test localized versions of our UI.

These tests will fail if screenshots are missing or different than those already
stored in Git. They will pass otherwise. TL;DR: run the tests twice when you
add new screenshots.

### Linting

Linting is done via 3 tools:

* Rubocop will lint Ruby files;
* SwiftLint & SwiftFormat are complementary tools to lint the code in terms of
  pure formatting (line-spaces, indentation, etc.) but also good practices (no
  weak outlets).

[cocoapods]: https://cocoapods.org
[rvm]: https://rvm.io/rvm/install
[xcode]: https://apps.apple.com/app/xcode/id497799835
