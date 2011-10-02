require 'fileutils'
require 'erb'

module Sandbox
  class Installer
    include Sandbox::Output
    extend Sandbox::Output

    class << self
    end

    attr_accessor :options

    def initialize(options={})
      @options = options.dup
      @target = nil
    end

    def target
      return @target unless @target.nil?
      @target = resolve_target(options[:target])
    end

    def populate
      tell("creating sandbox at: #{target}")
      create_directories
      tell("installing activation script")
      install_scripts
      tell("installing .gemrc")
      install_gemrc
      tell("installing gems")
      install_gems
    end

    ##
    # Create folders:
    #
    #     mkdir -p /path/to/sandbox/rubygems/bin
    #
    # Symlink the bin directory, because when gems are installed, binaries
    # are installed in GEM_HOME/bin:
    #
    #     $ ln -s /path/to/sandbox/rubygems/bin /path/to/sandbox/bin
    #
    def create_directories
      gembin = File.join(target, 'rubygems', 'bin')
      FileUtils.mkdir_p(gembin)

      bin = File.join(target, 'bin')
      FileUtils.ln_s(gembin, bin)
    end

    def install_gemrc
      filename = File.join(target, '.gemrc')
      template = File.read(File.dirname(__FILE__) + '/templates/gemrc.erb')
      output = ERB.new(template).result(binding)
      File.open(filename, 'w') { |f| f.write(output) }
    end

    def install_scripts
      filename = File.join(target, 'bin', 'activate')
      template = File.read(File.dirname(__FILE__) + '/templates/activate.erb')
      output = ERB.new(template).result(binding)
      File.open(filename, 'w') { |f| f.write(output) }
    end

    def install_gems
      gems = options[:gems] || []
      if gems.size == 0
        tell("  nothing to install")
        return
      end

      begin
        setup_sandbox_env
        gems.each do |gem|
          tell_unless_really_quiet("  gem: #{gem}")
          cmd = "gem install #{gem}"
          status, output = shell_out(cmd)
          unless status
            tell_unless_really_quiet("    failed to install gem: #{gem}")
          end
        end
      ensure
        restore_sandbox_env
      end
    end

    def shell_out(cmd)
      out = `#{cmd} 2>/dev/null`
      result = $?.exitstatus == 0
      [result, out]
    end

    def setup_sandbox_env
      @old_env = Hash[ *ENV.select { |k,v| ['HOME','GEM_HOME','GEM_PATH'].include?(k) }.flatten ]

      ENV['HOME']     = target
      ENV['GEM_HOME'] = "#{target}/rubygems"
      ENV['GEM_PATH'] = "#{target}/rubygems"
    end

    def restore_sandbox_env
      ENV['HOME']     = @old_env['HOME']
      ENV['GEM_HOME'] = @old_env['GEM_HOME']
      ENV['GEM_PATH'] = @old_env['GEM_PATH']
    end

    def resolve_target(path)
      path = fix_path(path)
      if File.exists?(path)
        raise Sandbox::Error, "target '#{path}' exists"
      end

      base = path
      while base = File.dirname(base)
        if check_path!(base)
          break
        elsif base == '/'
          raise "something is seriously wrong; we should never get here"
        end
      end

      path
    end

    def check_path!(path)
      if File.directory?(path)
        if File.writable?(path)
          return true
        else
          raise Sandbox::Error, "path '#{path}' has a permission problem"
        end
      elsif File.exists?(path)
        raise Sandbox::Error, "path '#{path}' is not a directory"
      end
      false
    end

    def fix_path(path)
      unless path.index('/') == 0
        path = File.join(FileUtils.pwd, path)
      end
      path
    end

  end

end
