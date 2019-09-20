app_dir = "/myapp"
working_directory app_dir
pid "#{app_dir}/tmp/unicorn.pid"

require_relative 'config/application'
Rails.application.load_tasks

stderr_path "/dev/stdout"
stdout_path "/dev/stdout"

number_of_workers = ENV["UNICORN_WORKERS"].to_i

worker_processes number_of_workers
#preload_app true
listen 3000, :backlog => 64
timeout 960

mysql_db = ENV["MYSQL_DATABASE"]
mysql_password = ENV["MYSQL_ROOT_PASSWORD"]
mysql_hostname = ENV["MYSQL_HOSTNAME"]

before_fork do |server, worker|
  defined?(ActiveRecord::Base) and
  ActiveRecord::Base.connection.disconnect!
  old_pid = "#{server.config[:pid]}.oldbin"
  if old_pid != server.pid
    begin
      sig = (worker.nr + 1) >= server.worker_processes ? :QUIT : :TTOU
      Process.kill(sig, File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
    end
  end
  sleep 1
end

after_fork do |server, worker|
  puts "Starting worker"
  ActiveRecord::Base.establish_connection
  #   :adapter  => "mysql2",
  #   :host     => mysql_hostname,
  #   :username => "root",
  #   :password => mysql_password,
  #   :database => mysql_db
  # )
  # suppliers = Supplier.all
  # products = Product.all
end
