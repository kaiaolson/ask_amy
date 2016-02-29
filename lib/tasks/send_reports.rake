namespace :send_reports do

# include description of what it does
  desc "Send all reports in the system"
  # :environment loads Rails environment, so have access to the app
  task :send_all => :environment do
    # SendAdminReportJob.perform_later()
    puts Cowsay.say("Sending Reports")
  end
end
