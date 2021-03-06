set :application, 'alphapitch'
set :repo_url, 'git@github.com:stryk/rarian.git'

# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

set :deploy_to, '/home/dk/www/alphapitch'
set :scm, :git

set :format, :pretty
set :branch, "master"
set :user, "dkspec"
set :use_sudo, false
set :rails_env, "production"
set :deploy_via, :copy

# set :log_level, :debug
set :pty, true
set :shared_files, ["config/application.yml", "config/database.yml"]

set :shared_children, %w{public/uploads public/uploads/ckeditor}

# set :linked_files, %w{config/database.yml}
# set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# set :default_env, { path: "/opt/ruby/bin:$PATH" }
set :keep_releases, 5


namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      # execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  # desc 'Update the crontab file'
  # task :update_crontab, :roles => :db do
  #   run "cd #{release_path} && whenever --update-crontab #{application}"
  # end


  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

  after :finishing, 'deploy:cleanup'

end
