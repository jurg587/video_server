task 'generate_docs' do
  require 'rspec/core/rake_task'

  RSpec::Core::RakeTask.new(:api_spec) do |t|
    t.pattern = 'spec/'
    t.rspec_opts = "-f Dox::Formatter --order defined --tag dox --out public/docs/v1/apispec.md"
  end

  Rake::Task['api_spec'].invoke
  `aglio -i public/docs/v1/apispec.md --theme-variables slate -o public/docs/v1/index.html`
  `google-chrome public/docs/v1/index.html`
end