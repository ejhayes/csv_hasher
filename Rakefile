require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

task :default => :spec
task :test => :spec

desc 'Interactive console with gem pre-loaded'
task :console do
  require 'irb'
  require 'irb/completion'
  require 'ruby-debug'
  $LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
  require 'csv_hasher'
  ARGV.clear
  IRB.start
end
