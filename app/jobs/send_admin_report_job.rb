class SendAdminReportJob < ActiveJob::Base
  queue_as :default

# variable number of arguments (comes in an array)
  def perform(*args)
    # write any kind of Ruby code...generate reports, fetch social media
    # to have access to a class that you can queue in the background
  end
end


# queue by calling it
# SendAdminReportJob.perform_later() or something
