require "csv"
namespace :db do
  desc "Import Admins from csv file"
  task admins: [:environment] do
    file = "db/admins.csv"
    CSV.foreach(file, headers: true) do |row|
      User.create name: row[0], email: row[1], password: row[2],
        password_confirmation: row[3], is_admin: row[4]
    end
  end
end
