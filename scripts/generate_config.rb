#! /usr/bin/env ruby
# frozen_string_literal: true

require 'YAML'
require 'Mustache'
require 'socket'
require 'fastlane_core'

yaml_path = ARGV.empty? ? 'config.yml' : "config.#{ARGV.first}.yml"
xcconfig_file_path = 'Environment.xcconfig'

config_params = YAML.load_file(yaml_path)

xconfig_template = <<~XCCONFIG_MUSTACHE_TEMPLATE
  // Environment.xcconfig

  // Configuration settings file format documentation can be found at:
  // https://help.apple.com/xcode/#/dev745c5c974

  APP_NAME = {{app_name}}

  // Unfortunately, xcconfig files treat the sequence // as a comment delimiter,
  // regardless of whether it’s enclosed in quotation marks.
  BACKEND_API_SCHEME = {{backend.scheme}}
  BACKEND_API_HOST = {{backend.host}}
  {{#backend.port}}
  BACKEND_API_PORT = {{backend.port}}
  {{/backend.port}}

  // Debug only params, optional and for developer's convenience.
  // Please prefix all of them by DEBUG_ so that they don't get shipped by
  // accident in release builds.
  {{#debug.user_email}}
  DEBUG_USER_EMAIL = {{debug.user_email}}
  {{/debug.user_email}}
  {{#debug.user_password}}
  DEBUG_USER_PASSWORD = {{debug.user_password}}
  {{/debug.user_password}}
XCCONFIG_MUSTACHE_TEMPLATE

UI = FastlaneCore::UI
if config_params['backend']['host'].nil?
  opts = Socket.ip_address_list.select(&:ipv4_private?).map(&:ip_address)

  if opts.empty?
    UI.error('No LAN IP was found.')
    exit(false)
  end

  lan_ip = opts.length == 1 ? opts.first : UI.select('Which LAN IP?', opts)
  config_params['backend']['host'] = lan_ip
  UI.important "API host set to #{lan_ip}"
end

xcconfig_file_body = Mustache.render(xconfig_template, config_params)
File.write(xcconfig_file_path, xcconfig_file_body)
UI.important "Config written in #{xcconfig_file_path}"
