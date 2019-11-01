# frozen_string_literal: true

# Uncomment the next line to define a global platform for your project
platform :ios, '12.2'

target 'client-ios' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for client-ios
  pod 'SwiftFormat/CLI'
  pod 'SwiftLint'

  target 'client-iosTests' do
    inherit! :search_paths
    # Pods for testing
    pod 'SnapshotTesting'
  end

  target 'client-iosUITests' do
    inherit! :complete
    # Pods for testing
  end
end
