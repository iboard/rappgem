require "bundler/gem_tasks"

task :default => :rspec

desc "Run entire test suite"
task :rspec do
  task(:rappgem).invoke
  task(:sinatra).invoke
end

desc "RappGem Tests"
task :rappgem do
  puts "TEST RAPPGEM"
  system "rspec -f d spec/"
end

desc "Run Sinatra example tests"
task :sinatra do
  puts "\nTEST SINATRA EXAMPLE"
  system "cd examples/sinatra && rspec -f d spec/ ; cd -"
end

desc "Build documentation and run tests in ordered mode"
task :doc do
  puts "\nBUILDING DOCUMENTATION"
  system "yard"
  puts "\nSPECS IN DEFINED ORDER"
  system "rspec -fd --order=defined spec"
end
