namespace :build do

  JS_SCAFFOLD = "rails g faalis:js:list_view"

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
    menus = "--menu Namespaces:namespaces{Namespace},Sites:sites{SiteFramework::Site},Categories:site_categories#{SiteCategory}"
    deps = "--deps namespace"
    fields = "title:string category:belongs_to:site_categories description:text"
    system "#{JS_SCAFFOLD} site #{fields} #{menus} #{deps} --no-filter --no-bulk --model SiteFramework::Site"
  end

  desc "Create namespace scaffold"
  task :namespace => :environment do
    system "#{JS_SCAFFOLD} namespace name:string"
  end

  desc "Create site category scaffold"
  task :site_category => :environment do
    system "#{JS_SCAFFOLD} site_category name:string description:text --no-bulk --no-filter"
  end
end
