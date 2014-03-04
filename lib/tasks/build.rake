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

  desc "Create Sites scaffold"
  task :site => :environment do
    menus = "--menu Namespaces:namespaces,Sites:sites"
    system "#{JS_SCAFFOLD} name title:string category:belongs_to:site_categories description:text #{menus} --no-filter --no-bulk"
  end

  desc "Create namespace scaffold"
  task :namespace => :environment do
    system "#{JS_SCAFFOLD} namespace name:string"
  end
end
