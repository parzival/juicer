require 'juicer/minifyer/compressor_base'

module Juicer
    module Minifyer
    
        class RainpressCompressor
            begin 
                require 'rainpress'
                RAINPRESS_LOADED = true
            rescue LoadError
                RAINPRESS_LOADED = false
            end

            include Juicer::Minifyer::CompressorBase
            
            def initialize(options = {})
                if not RAINPRESS_LOADED
                    raise NameError
                end
                
                test_for_rainpress = Rainpress.new("")
                
            end
            
            private
            
            def compress(file,output)
                File.open(output, "w") do |output_file|
                    output_file.print Rainpress.compress(File.read(file))
                end
            end
        end
    end
end
