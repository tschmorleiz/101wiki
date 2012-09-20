require "rvm/capistrano"  
require 'bundler/capistrano'

set :application, "101wiki"
set :repository,  "set your repository location here"

set :scm, :git
set :scm_command, "/usr/local/bin/git"

# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :web, "sl-mac.uni-koblenz.de"                          # Your HTTP server, Apache/etc
role :app, "sl-mac.uni-koblenz.de"                          # This may be the same as your `Web` server
role :db,  "sl-mac.uni-koblenz.de", :primary => true # This is where Rails migrations will run

default_run_options[:pty] = true  # Must be set for the password prompt
                                  # from git to work
set :repository, "git://github.com/101companies/101wiki.git"  # Your clone URL
set :branch, "master"
#set :use_sudo, true
set :user, "wiki101"

set :deploy_to, "/Users/wiki101/Sites/101wiki"
set :deploy_via, :remote_cache
ssh_options[:forward_agent] = true
ssh_options[:keys] = [File.join(ENV["HOME"], ".ssh", "id_rsa")] 

set :rvm_ruby_string, '1.9.3@101wiki'
set :rvm_type, :user

#set :user, "deployer"  # The server's user for deploys
#set :scm_passphrase, "p@ssw0rd"  # The deploy user's password

# if you want to clean up old releases on each deploy uncomment this:
after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
 namespace :deploy do
   task :start do ; end
   task :stop do ; end
   task :restart, :roles => :app, :except => { :no_release => true } do
     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
   end
 end