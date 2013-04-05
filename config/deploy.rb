require "bundler/capistrano"
load 'deploy/assets'

set :application, "store"
set :user, "bt"
set :repository,  "git@github.com:bsch/bend_trailers.git"

# set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

server = "bt1.bendtrailers.com"
role :web, server                        # Your HTTP server, Apache/etc
role :app, server                          # This may be the same as your `Web` server
role :db,  server, :primary => true # This is where Rails migrations will run
#role :db,  "your slave db-server here"



set :deploy_to, "/home/bt/#{application}"
set :use_sudo, false

default_run_options[:shell] = '/bin/bash --login'
default_environment["RAILS_ENV"] = 'production'

task :symlink_database_yml do
  run "rm #{release_path}/config/database.yml"
  run "ln -sfn #{shared_path}/config/database.yml 
       #{release_path}/config/database.yml"
end
after "bundle:install", "symlink_database_yml"




