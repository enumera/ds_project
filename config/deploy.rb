# config valid only for current version of Capistrano
lock '3.4.0'

set :rvm_type, :user                     # Defaults to: :auto
# set :rvm_ruby_version, '2.0.0-p247'      # Defaults to: 'default'
# set :rvm_custom_path, '/usr/share/rvm/'  # only needed if not detected
set :use_sudo, true
set :pty, true

set :application, 'andy'
set :repo_url, "git@github.com:enumera/ds_project.git"
set :branch, 'development'

set :scm, :git

set :linked_files, fetch(:linked_files, []).push('config/unicorn/production.rb', 'config/database.yml')
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/sockets', 'vendor/bundle', 'public/system', 'config/unicorn')

set :deploy_to, '/var/www/sites/momentum'

set :format, :pretty

set :keep_releases, 3

namespace :deploy do
  task :restart do
    invoke 'unicorn:legacy_restart'
  end
end

after 'deploy:publishing', 'deploy:restart'