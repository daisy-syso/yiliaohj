require 'mina/bundler'
require 'mina/rails'
require 'mina/git'
require 'mina/rvm' # for rvm support. (http://rvm.io)

set :domain, '61.153.100.122'
set :deploy_to, '/home/ubuntu/yiliaohj'
set :repository, 'git@github.com:daisy-syso/yiliaohj.git'
set :branch, 'master'
set :keep_releases, 5
set :rails_env, 'production'
set :rvm_path, '/home/ubuntu/.rvm/bin/rvm'

# Manually create these paths in shared/ (eg: shared/config/database.yml) in your server.
# They will be linked in the 'deploy:link_shared_paths' step.
set :shared_paths, ['log', 'tmp/pids']

# Optional settings:
set :user, 'ubuntu' # Username in the server to SSH to.
#   set :forward_agent, true     # SSH forward_agent.

# This task is the environment that is loaded for most commands, such as
# `mina deploy` or `mina rake`.

task :environment do
  invoke :'rvm:use[ruby-2.1.2]'
end

# Put any custom mkdir's in here for when `mina setup` is ran.
# For Rails apps, we'll make some of the shared paths that are shared between
# all releases.
task setup: :environment do
  queue! %(mkdir -p "#{deploy_to}/shared/tmp")
  queue! %(chmod g+rx,u+rwx "#{deploy_to}/shared/tmp")

  queue! %(mkdir -p "#{deploy_to}/#{shared_path}/tmp/pids")
  queue! %(chmod g+rx,u+rwx "#{deploy_to}/#{shared_path}/tmp/pids")

  queue! %(mkdir -p "#{deploy_to}/#{shared_path}/log")
  queue! %(chmod g+rx,u+rwx "#{deploy_to}/#{shared_path}/log")
end

desc 'Deploys the current version to the server.'
task deploy: :environment do
  deploy do
    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'
    invoke :'bundle:install'
    invoke :'rails:assets_precompile'
    invoke :'deploy:cleanup'

    to :launch do
      queue 'bundle exec thin stop'
      queue 'bundle exec thin start -p 6000 -e production -d'
      # queue "whenever -w"

      queue! 'kill -9 `cat /home/ubuntu/yiliaohj/shared/tmp/pids/sidekiq.pid`'
      queue! 'bundle exec sidekiq -C /home/ubuntu/yiliaohj/current/config/sidekiq.yml -e production'
    end
  end
end
