module Sunspot #:nodoc:
  module Padrino #:nodoc:
    # 
    # This module adds an after action to Padrino::Application that commits
    # the Sunspot session if any documents have been added, changed, or removed
    # in the course of the request.
    #
    module RequestLifecycle
      class <<self
        def included(base) #:nodoc:
          base.subclasses.each do |application|
            application.after do
              if Sunspot::Padrino.configuration.auto_commit_after_request?
                Sunspot.commit_if_dirty
              elsif Sunspot::Padrino.configuration.auto_commit_after_delete_request?
                Sunspot.commit_if_delete_dirty
              end
            end 
          end
        end
      end
    end
  end
end
