ENV['SINATRA_ENV'] ||= "development"
ENV['SESSION_SECRET'] = "export SESSION_SECRET=17f61487413f117cb64398d5a96abc8d506cc56dc7e46c0a8495cb1d872a44c5736be1500a69a4a9d347e1a544cae84b7e0b1362040ede2ea44b6d71f00082f6 >> ~/.bashrc"

require 'bundler/setup'
Bundler.require(:default, ENV['SINATRA_ENV'])

ActiveRecord::Base.establish_connection(
  :adapter => "sqlite3",
  :database => "db/#{ENV['SINATRA_ENV']}.sqlite"
)

require_all 'app'
