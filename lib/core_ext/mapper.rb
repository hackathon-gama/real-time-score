# frozen_string_literal: true

module ActionDispatch
  module Routing
    Mapper.class_eval do
      def resources_api(*args, &)
        args << {} if args.size == 1
        args[1][:except] ||= []
        args[1][:except] = args[1][:except] | %i[new edit]
        resources(*args, &)
      end
    end
  end
end
