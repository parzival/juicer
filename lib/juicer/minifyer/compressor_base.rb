require 'juicer/chainable'

module Juicer
    module Minifyer
    
        # Provides an interface to compressors that save the output 
        # to a specified file (or use a temporary intermediate file).
    
        # Specifics of compression must be implemented using the compress method.
    
        # Author::    Christian Johansen (christian@cjohansen.no), Michael Winterstein (m_wint@runbox.us)
        # Copyright:: Copyright (c) 2008-2009 Christian Johansen, (c) 2012 M. Winterstein
        # License::   MIT
    
        module CompressorBase
            include Juicer::Chainable
        
            def save(file, output=nil, type=nil)
                @type = type || file.split('.')[-1].to_sym 
                
                @overwrite_source = false
                output = create_temp_output(file) unless output
                        
                out_dir = File.dirname(output)
                FileUtils.mkdir_p(out_dir) unless File.exists?(out_dir)
                
                compress(file,output)
                
                if @overwrite_source
                    FileUtils.move(output, file, :force=>true)
                end
            end
        
            chain_method :save
            
            private
            
            # Creates a temporary file based on the input.  Should set
            # @overwrite_source to true if the output should be written
            # back to the input file.
            def create_temp_output(file)
                @overwrite_source = true
                File.join(Dir::tmpdir, File.basename(file) + '.min.tmp.' + @type.to_s)
            end
                    
        end
    end
end
        