module UseCases
  class Base
    def self.call(...)
      new(...).call
    end

    def call
      raise(NotImplementedError, 'Not implemented yet')
    end
  end
end
