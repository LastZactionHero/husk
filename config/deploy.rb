require "rvm/capistrano"
require "bundler/capistrano"

set :whenever_command, "bundle exec whenever"
set :whenever_environment, defer { rails_env }
set :whenever_identifier, defer { "#{application}_#{rails_env}" }
require "whenever/capistrano"


set :application, "local_favorite"
set :keep_releases, 5

# set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

set :scm, :git
set :scm_user, "LastZactionHero"
set :repository, "git@github.com:LastZactionHero/local_favorite.git"
ssh_options[:forward_agent] = true

set :user, "root"
server "localfavorite.yuccasix.com", :app, :web, :db, :primary => true

set :application, "local_favorite"
set :deploy_to, "/var/www/#{application}"

set :rvm_type, :system

# role :web, "your web-server here"                          # Your HTTP server, Apache/etc
# role :app, "your app-server here"                          # This may be the same as your `Web` server
# role :db,  "your primary db-server here", :primary => true # This is where Rails migrations will run
# role :db,  "your slave db-server here"

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :config_symlink do
    puts "Running this!"
    run "cp #{shared_path}/config/database.yml #{release_path}/config/database.yml"
    run "cp #{shared_path}/config/secrets.yml #{release_path}/config/secrets.yml"
    run "cp #{shared_path}/config/settings.yml #{release_path}/config/settings.yml"
    puts "Ran it!"
  end

  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

before "deploy:assets:symlink","deploy:config_symlink"
after 'deploy:update_code', 'deploy:migrate'
after "deploy:restart", "deploy:cleanup"
