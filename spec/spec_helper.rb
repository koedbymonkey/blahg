require 'rubygems'
require 'spork'
require 'simplecov'

ENV['SKIP_RAILS_ADMIN_INITIALIZER'] = 'false'

# Spork & Spork rails apparently suck at helpers.
# See:
#   - https://github.com/sporkrb/spork/pull/140
#   - https://github.com/sporkrb/spork/issues/109
#   - https://github.com/sporkrb/spork-rails/issues/6
AbstractController::Helpers::ClassMethods.module_eval do
  def helper *args, &block
    modules_for_helpers(args).each { |mod| add_template_helper mod }
    _helpers.module_eval &block if block_given?
  end
end if Spork.using_spork?

Spork.prefork do
  # Loading more in this block will cause your tests to run faster. However,
  # if you change any configuration or code from libraries loaded here, you'll
  # need to restart spork for it take effect.

  SimpleCov.start 'rails' unless ENV['DRB']

  ENV['RAILS_ENV'] ||= 'test'

  require 'rails/application'
  Spork.trap_method Rails::Application::RoutesReloader, :reload!

  require File.expand_path('../../config/environment', __FILE__)
  require 'rspec/rails'
  require 'capybara/rspec'

  ActiveSupport::Deprecation.silenced = true

  Capybara.javascript_driver = :poltergeist

  Capybara.register_driver :poltergeist_debug do |app|
    Capybara::Poltergeist::Driver.new app, timeout: 6000
  end

  RSpec.configure do |config|
    config.filter_run focus: true
    config.mock_with  :rspec

    config.run_all_when_everything_filtered                = true
    config.treat_symbols_as_metadata_keys_with_true_values = true
    config.use_transactional_fixtures                      = false

    config.before :suite do
      %w[ commenter ].each {|n| Role.where(name: n).first_or_create }
      DatabaseCleaner.strategy = :truncation, { except: %w[ roles ] }
    end

    config.before :each do
      SimpleCov.command_name "RSpec:#{ Process.pid.to_s }#{ ENV['TEST_ENV_NUMBER'] }"
      DatabaseCleaner.start
    end

    config.before :each, debug: true do
      Capybara.current_driver = :poltergeist_debug
    end

    config.after :each, debug: true do
      Capybara.use_default_driver
    end

    config.after :each do
      DatabaseCleaner.clean
    end

    config.after :suite do
      Role.delete_all
    end
  end

end

Spork.each_run do
  # This code will be run each time you run your specs.
  SimpleCov.start 'rails' if ENV['DRB']

  Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }
  FactoryGirl.reload
end
