threads_count = ENV.fetch('RAILS_MAX_THREADS') { 5 }
threads threads_count, threads_count

if Rails.env.production?
  environment ENV.fetch('RAILS_ENV') { 'produciton' }
  tmp_path = '/var/www/book-output/tmp'
  bind "unix://#{tmp_path}/sockets/puma.sock"

  workers 2
  preload_app!

  pidfile "#{tmp_path}/pids/puma.pid"
else
  environment ENV.fetch('RAILS_ENV') { 'development' }
  port        ENV.fetch('PORT') { 3000 }
end

plugin :tmp_restart
