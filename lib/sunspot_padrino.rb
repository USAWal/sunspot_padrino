require "sunspot_padrino/version"
require "active_support/core_ext"

require "sunspot"
require "sunspot_padrino/configuration"
require "sunspot_padrino/adapters"
require "sunspot_padrino/request_lifecycle"
require "sunspot_padrino/searchable"

Module Sunspot
  Module Padrino
    autoload :SolrInstrumentation, File.join(File.dirname(__FILE__), 'sunspot_padrino', 'solr_instrumentation')
    autoload :StubSessionProxy, File.join(File.dirname(__FILE__), 'sunspot_padrino', 'stub_session_proxy')
    begin
      require 'sunspot_solr'
      autoload :Server, File.join(File.dirname(__FILE__), 'sunspot_padrino', 'server')
    rescue LoadError => e
      # We're fine
    end

    class <<self
      attr_writer :configuration

      def configuration
        @configuration ||= Sunspot::Padrino::Configuration.new
      end

      def reset
        @configuration = nil
      end

      def build_session(configuration = self.configuration)
        if configuration.disabled?
          StubSessionProxy.new(Sunspot.session)
        elsif configuration.has_master?
          SessionProxy::MasterSlaveSessionProxy.new(
            SessionProxy::ThreadLocalSessionProxy.new(master_config(configuration)),
            SessionProxy::ThreadLocalSessionProxy.new(slave_config(configuration))
          )
        else
          SessionProxy::ThreadLocalSessionProxy.new(slave_config(configuration))
        end
      end

      private

      def master_config(sunspot_padrino_configuration)
        config = Sunspot::Configuration.build
        config.solr.url = URI::HTTP.build(
          :host => sunspot_padrino_configuration.master_hostname,
          :port => sunspot_padrino_configuration.master_port,
          :path => sunspot_padrino_configuration.master_path
        ).to_s
        config
      end

      def slave_config(sunspot_padrino_configuration)
        config = Sunspot::Configuration.build
        config.solr.url = URI::HTTP.build(
          :host => sunspot_padrino_configuration.hostname,
          :port => sunspot_padrino_configuration.port,
          :path => sunspot_padrino_configuration.path
        ).to_s
        config
      end
    end
  end
end

require "sunspot_padrino/railtie"
