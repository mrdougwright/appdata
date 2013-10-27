require "bundler/capistrano"

set :application, "appdata"
set :repository,  "git@github.com:mrdougwright/appdata.git"
set :deploy_to, "/var/www/#{application}" # could comment out
set :scm, :git
set :scm_passphrase, ""
set :branch, "master"
set :user, "doug"
set :use_sudo, false
set :rails_env, "production"
set :deploy_via, :copy
set :ssh_options, { :forward_agent => true, :port => 22 }
set :keep_releases, 5

# default_run_options[:pty] = true
server "162.243.137.33", :app, :web, :db, primary: true

# for linking application.yml file for Figaro ~ database.yml
desc "Symlink shared config files"
task :symlink_config_files do
  run "#{ try_sudo } ln -s #{ deploy_to }/shared/config/application.yml #{ current_path }/config/application.yml"
end 

desc "Restart Passenger app"
task :restart do
  run "#{ try_sudo } touch #{ File.join(current_path, 'tmp', 'restart.txt') }"
end  

after "deploy", "deploy:symlink_config_files"
after "deploy", "deploy:restart"
after "deploy", "deploy:cleanup"
