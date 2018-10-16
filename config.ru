require './config/environment'

if ActiveRecord::Base.connection.migration_context.needs_migration?
  raise 'Migrations are pending. Run `rake db:migrate SINATRA_ENV=test` to resolve the issue.'
end

use Rack::MethodOverride

use UserController
use PostController
use CommentController
run ApplicationController
