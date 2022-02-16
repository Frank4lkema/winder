desc "collect data from the web "
task :collect_data => [:environment] do

  Services::ScrapSite.call("https://www.windguru.cz/48299")
  puts "Collected Data"
end