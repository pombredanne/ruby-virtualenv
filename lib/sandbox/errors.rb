module Sandbox
  class Error < StandardError

    def initialize(msg=nil)
      super(msg)
    end

    def message
      out = [super]
      out.concat(backtrace.collect { |bt| "    #{bt}" }) if Sandbox.really_verbose?
      out.join("\n")
    end

  end

  class LoadedSandboxError < Sandbox::Error
    def initialize(msg="You cannot run sandbox from a loaded sandbox environment")
      super(msg)
    end
  end

  class ParseError < Sandbox::Error

    def initialize(reason=nil, args=[])
      msg = if args.is_a?(Array) && args.size > 0
        "#{reason} => #{args.join(' ')}"
      elsif args.is_a?(String) && args.length > 0
        "#{reason} => #{args}"
      else
        reason
      end

      super(msg)
    end

  end

end
