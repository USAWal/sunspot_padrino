module Sunspot
  module Padrino
    class Server < Sunspot::Solr::Server
      # ActiveSupport log levels are integers; this array maps them to the
      # appropriate java.util.logging.Level constant
      LOG_LEVELS = %w(FINE INFO WARNING SEVERE SEVERE INFO)

      # 
      # Directory in which to store PID files
      #
      def pid_dir
        configuration.pid_dir || File.join(::Padrino.root, 'tmp', 'pids')
      end

      # 
      # Name of the PID file
      #
      def pid_file
        "sunspot-solr-#{::Padrino.env}.pid"
      end

      # 
      # Directory to store lucene index data files
      #
      # ==== Returns
      #
      # String:: data_path
      #
      def solr_data_dir
        configuration.data_path
      end

      # 
      # Directory to use for Solr home.
      #
      def solr_home
        File.join(configuration.solr_home)
      end

      #
      # Solr start jar
      #
      def solr_jar
        configuration.solr_jar || super
      end

      # 
      # Address on which to run Solr
      #
      def bind_address
        configuration.bind_address
      end

      # 
      # Port on which to run Solr
      #
      def port
        configuration.port
      end

      #
      # Severity level for logging. This is based on the severity level for the
      # Padrino logger.
      #
      def log_level
        LOG_LEVELS[::Padrino.logger.level]
      end

      # 
      # Log file for Solr. File is in the padrino log/ directory.
      #
      def log_file
        File.join(::Padrino.root, 'log', "sunspot-solr-#{::Padrino.env}.log")
      end

      # 
      # Minimum Java heap size for Solr
      #
      def min_memory
        configuration.min_memory
      end

      # 
      # Maximum Java heap size for Solr
      #
      def max_memory
        configuration.max_memory
      end

      private

      #
      # access to the Sunspot::Padrino::Configuration, defined in
      # sunspot.yml. Use Sunspot::Padrino.configuration if you want
      # to access the configuration directly.
      #
      # ==== returns
      #
      # Sunspot::Padrino::Configuration:: configuration
      #
      def configuration
        Sunspot::Padrino.configuration
      end
    end
  end
end
