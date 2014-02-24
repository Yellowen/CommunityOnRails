namespace :destroy do
  DS_SCAFFOLD = "rails d faalis:js_scaffold"
  desc "Destroy the settings scaffold"
  task :settings => :environment do
    # TODO: Add support for fetching combo options from a function.
    system "#{DS_SCAFFOLD} setting"
  end

end
