# Native libs
require 'benchmark'
require 'thread'
require 'thread_safe'
require 'yaml'

# Gems
require 'rest-client'

# Core extensions
require 'active_support/core_ext/benchmark'
require 'active_support/core_ext/module/delegation'
require 'active_support/core_ext/module/attribute_accessors'
require 'active_support/core_ext/hash/indifferent_access'

# Project files
require_relative 'queue_with_timeout'
require_relative 'github'
require_relative 'jobs/repo_job'
require_relative 'worker'

# App config
CONFIG = YAML.load_file(File.join(File.expand_path('../', File.dirname(__FILE__)), 'config/config.yml')).symbolize_keys!

# Github config
GITHUB = Github.new do |config|
  config.oauth_token = CONFIG[:oauth_token]
end
