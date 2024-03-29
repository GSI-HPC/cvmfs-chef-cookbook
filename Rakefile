begin
  require 'rubocop/rake_task'
  RuboCop::RakeTask.new do |task|
    task.options = %w[--display-cop-names --display-style-guide --lint]
  end
rescue LoadError
  desc 'rubocop rake task not available'
  task :rubocop do
    abort 'Rubocop rake task is not available. Be sure to install rubocop'
  end
end

begin
  require 'foodcritic'
  FoodCritic::Rake::LintTask.new do |task|
    task.options = {
      context: true,
      exclude_paths: ['example_config/**/*'],
      # FC069: no standard license
      # FC071: no LICENSE file
      # FC079: no OSI approved license
      tags: %w[~FC069 ~FC071 ~FC078]
    }
  end
rescue LoadError
  desc 'foodcritic rake task not available'
  task :foodcritic do
    abort 'Foodcritic rake task is not available. Be sure to install foodcritic'
  end
end

begin
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new(:chefspec) do |task|
    task.pattern = 'test/unit/**/*_spec.rb'
    task.rspec_opts = '--backtrace --color --format documentation '\
                      '--require spec_helper --default-path test/unit'
  end
rescue LoadError
  desc 'chefspec rake task not available'
  task :chefspec do
    abort 'Chefspec rake task is not available. Be sure to install chefspec'
  end
end

begin
  require 'kitchen/rake_tasks'
  Kitchen::RakeTasks.new do
    Kitchen.logger = Kitchen.default_logger
  end
rescue LoadError
  desc 'kitchen rake task not available'
  task :kitchen do
    abort 'kitchen rake task is not available. Be sure to install test-kitchen'
  end
end

begin
  require 'yard'
  YARD::Config.load_plugin 'chef'
  YARD::Rake::YardocTask.new do |t|
    t.files = ['**/*.rb']
    t.options = ['--debug']
  end
rescue LoadError
  desc 'yard rake task not available'
  task :yard do
    abort 'yard rake task is not available. '\
          'Be sure to install yard and yard-chef'
  end
end

task default: %w[rubocop foodcritic chefspec kitchen:all]
