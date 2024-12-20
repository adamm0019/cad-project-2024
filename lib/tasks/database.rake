namespace :db do
  desc "Checks if database exists"
  task :exists do
    begin
      # Check if database exists by attempting to get its version
      Rake::Task["db:version"].invoke
    rescue
      exit 1
    else
      exit 0
    end
  end
end
