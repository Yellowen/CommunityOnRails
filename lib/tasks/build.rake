namespace :build do

  JS_SCAFFOLD = "rails generate faalis:js_scaffold"

  desc "Build a fresh database"
  task :fresh => :environment do
    system "rm db/development.sqlite3"
    system "rake db:migrate --trace"
    system "rake db:seed --trace"
  end

  # TODO: Remove this scaffold and replace it with custom one
  desc "Create the settings scaffold"
  task :settings => :environment do
    # TODO: Add support for fetching combo options from a function.
    system "#{JS_SCAFFOLD} setting theme:in:default,clean --no-bulk"
  end

end
