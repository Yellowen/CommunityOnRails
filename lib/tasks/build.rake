namespace :build do

  LIST_VIEW = "rails g faalis:js:list_view lib/scaffold/list_view/"

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
    system "#{LIST_VIEW} setting theme:in:default,clean --no-bulk"
  end

  desc "Create Sites scaffold"
  task :site => :environment do
    system "#{LIST_VIEW}site.json"
  end

  desc "Create namespace scaffold"
  task :namespace => :environment do
    system "#{LIST_VIEW} namespace name:string"
  end

  desc "Create site category scaffold"
  task :site_category => :environment do
    system "#{LIST_VIEW} site_category name:string description:text --no-bulk --no-filter"
  end
end
