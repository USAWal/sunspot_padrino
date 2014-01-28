module Sunspot
  module Padrino
    Padrino.before_load do
      Sunspot.session = Sunspot::Padrino.build_session
        ActiveSupport.on_load(:active_record) do
          Sunspot::Adapters::InstanceAdapter.register(Sunspot::Padrino::Adapters::ActiveRecordInstanceAdapter, ActiveRecord::Base)
          Sunspot::Adapters::DataAccessor.register(Sunspot::Padrino::Adapters::ActiveRecordDataAccessor, ActiveRecord::Base)
          include(Sunspot::Padrino::Searchable)
        end
        ActiveSupport.on_load(:action_controller) do
          include(Sunspot::Padrino::RequestLifecycle)
        end
        require 'sunspot/padrino/log_subscriber'
        RSolr::Connection.module_eval{ include Sunspot::Padrino::SolrInstrumentation }

        # Expose database runtime to controller for logging.
        #require "sunspot/rails/railties/controller_runtime"
        #ActiveSupport.on_load(:action_controller) do
        #  include Sunspot::Rails::Railties::ControllerRuntime
        #end

        load 'sunspot/padrino/tasks.rake'
      end
    end
  end
end
