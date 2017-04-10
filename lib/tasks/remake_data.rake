namespace :db do
  desc "Import data"
  task :remake_data do
    puts "**********Reset Database**********"
    Rake::Task["db:migrate:reset"].invoke
    puts "**********Create Admin**********"
    Rake::Task["db:admins"].invoke
    puts "**********Create User**********"
    Rake::Task["db:users"].invoke
    puts "**********Create Category**********"
    Rake::Task["db:categories"].invoke
    puts "**********Create Word**********"
    Rake::Task["db:words"].invoke
  end
end
