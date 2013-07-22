# A sample Guardfile
# More info at https://github.com/guard/guard#readme
guard 'bundler' do
  watch('Gemfile')
end

guard 'spork', rspec_env: { 'RAILS_ENV' => 'test' } do
  watch %r{^config/initializers/.+\.rb$}
  watch 'config/application.rb'
  watch 'config/environment.rb'
  watch 'config/environments/test.rb'
  watch 'Gemfile'
  watch 'Gemfile.lock'
  watch '.env'
  watch(%r{^lib/.+\.rb$}) { :rspec }
  watch('spec/spec_helper.rb') { :rspec }
end

guard 'rspec', cli: '--color --drb -fp --tty' do
  watch(%r{^lib/(.+)\.rb$})     { |m| "spec/lib/#{m[1]}_spec.rb" }
  watch(%r{^spec/.+_spec\.rb$})
  watch('spec/spec_helper.rb')  { "spec" }

  # Rails example
  watch(%r{^app/(.*)(\.erb|\.haml)$})                 { |m| "spec/#{m[1]}#{m[2]}_spec.rb" }
  watch(%r{^app/(.+)\.rb$})                           { |m| "spec/#{m[1]}_spec.rb" }
  watch(%r{^app/controllers/(.+)_(controller)\.rb$})  { |m| %W[ spec/#{m[2]}s/#{m[1]}_#{m[2]}_spec.rb spec/features/#{m[1]}_#{m[2]}_spec.rb ] }
  watch(%r{^spec/support/(.+)\.rb$})                  { 'spec' }
  watch('app/controllers/application_controller.rb')  { %w[ spec/controllers spec/features ] }

  # Capybara features specs
  watch(%r{^app/views/(.+)/.*\.(erb|haml)$})          { |m| "spec/features/#{m[1]}_spec.rb" }
end
