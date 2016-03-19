root = "/var/www/sites/momentum/current"
working_directory root
pid "#{root}/tmp/pids/unicorn.pid"
stderr_path "#{root}/log/unicorn.log"
stdout_path "#{root}/log/unicorn.log"
ENV["RACK_ENV"] = "production"
listen "/tmp/unicorn.andy.sock"
worker_processes 3
timeout 90

before_exec do |_|
  ENV["BUNDLE_GEMFILE"] = File.join(root, 'Gemfile')
end