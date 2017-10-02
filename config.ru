require './config/environment'
require 'rack-flash'

if ActiveRecord::Migrator.needs_migration?
  raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
end

use Rack::MethodOverride
use UserController
use CollectionController
use PenController
use InkController
run ApplicationController
