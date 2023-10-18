set :stage,           :production
set :rails_env,       :production
set :branch,          :main

set :application,     'airbnbclone'
set :deploy_to,       "/home/#{fetch(:user)}/#{fetch(:application)}"
set :puma_bind,       "unix://#{shared_path}/sockets/puma.sock"

server '54.169.250.154', user: fetch(:user), roles: [:web, :app, :db], primary: true