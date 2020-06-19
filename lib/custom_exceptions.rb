module CustomExceptions
  class CustomError < StandardError
    attr_reader :errors
    def initialize(errors = nil)
      @errors = errors
    end
  end

  class Authorization < CustomError; end
  class Authentication < CustomError; end
end