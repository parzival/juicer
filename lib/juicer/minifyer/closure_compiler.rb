#!/usr/bin/env ruby
require 'tempfile'
require 'juicer/minifyer/java_base'
require 'juicer/chainable'

module Juicer
  module Minifyer

    # Provides an interface to the Closure compiler library using
    # Juicer::Shell::Binary. The Closure compiler library is implemented
    # using Java, and as such Java is required when running this code. Also, the
    # compiler jar file has to be provided.
    #
    # The Closure Compiler is invoked using the java binary and the compiler
    # jar file.
    #
    # Providing the Jar file (usually compiler.jar) can be done in
    # several ways. The following directories are searched (in preferred order)
    #
    #  1. The directory specified by the option :bin_path
    #  2. The directory specified by the environment variable $CLOSUREC_HOME, if set
    #  3. Current working directory
    #
    # For more information on how the Jar is located, see
    # +Juicer::Minify::ClosureCompiler.locate_jar+
    #
    # Author::    Christian Johansen (christian@cjohansen.no), Pavel Valodzka (pavel@valodzka.name)
    # Copyright:: Copyright (c) 2008-2009 Christian Johansen, (c) 2009 Pavel Valodzka
    # License::   MIT
    #
    # = Usage example =
    # closure = Juicer::Minifyer::ClosureCompiler.new
    # closure.java = "/usr/local/bin/java" # If 'java' is not on path
    # closure.path << "/home/user/java/yui_compressor/"
    # closure.save("", "")
    #
    class ClosureCompiler
      include Juicer::Minifyer::JavaBase
      #include Juicer::Chainable

      # Compresses a file using the YUI Compressor. Note that the :bin_path
      # option needs to be set in order for YuiCompressor to find and use the
      # YUI jar file. Please refer to the class documentation for how to set
      # this.
      #
      # file = The file to compress
      # output = A file or stream to save the results to. If not provided the
      #          original file will be overwritten
      # type = Either :js or :css. If this parameter is not provided, the type
      #        is guessed from the suffix on the input file name
             
      def self.bin_base_name
        "*compiler"
      end

      def self.env_name
        "CLOSUREC_HOME"
      end

     private

        # Executes the required compression on the input and output files
        def compress(file, output)
          execute(%Q{-jar "#{locate_jar}"#{jar_args} --js_output_file "#{output}" --js "#{file}"})
        end

      # Some class level options may be set:
      # :bin_path (defaults to Dir.cwd)
      # :java     (Java command, defaults to 'java')
      def default_options
        { }
      end
    end
  end
end
