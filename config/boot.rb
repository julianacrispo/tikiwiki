# Set up gems listed in the Gemfile.
require 'rubygems'

if File.exists?('.env') # Beyond local, '.env' won't exist
  env_lines = File.read(".env").split("\n")
  env_lines.each do |line|
    key, value = line.split("=")
    ENV[key] ||= value
  end
end

ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../../Gemfile', __FILE__)

require 'bundler/setup' if File.exist?(ENV['BUNDLE_GEMFILE'])

