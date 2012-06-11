require "test_helper"
require "juicer/minifyer/rainpress_compressor"


class RainpressCompressorTest < Test::Unit::TestCase

    def setup
        @input = "in-file.css"
        @output = "out-file.css"
        File.open( @input, "w") { |f| f.puts "Testing" }
        @rainpress = Juicer::Minifyer::RainpressCompressor.new
    end
    
    def teardown
        File.delete(@input)
        File.delete(@output) if File.exist?(@output)
        FileUtils.rm_rf("some") if File.exists?("some")
    end
    
    
    context "#save" do
        should "overwrite existing file" do
            # check rainpress execution?
            @rainpress.save(@input,@input)
        end
        
        should "write compressed input to output" do
            # check rainpress execution?           
            @rainpress.save(@input, @output)
            #assert File.exist?(@output)
        end
        
        should "create non-existant path" do
            FileUtils.rm_rf("some") if File.exists?("some")
            output_dir = "some/new/directory"
            @output = File.join(output_dir,@output)
            @rainpress.save(@input,@output)
            assert File.exist?(@output)
        end
    end
    
    context "locating gem" do
        should "not use minifyer if gem unavailable" do
            with_constant_unavailable('Rainpress') do
                # Expect gem installation message?
                
                assert_raise NameError do
                    Juicer::Minifyer::RainpressCompressor.new
                end
            end
            # check for NameError?
        end
        
        should "execute if gem can be found" do
            rainpress = Juicer::Minifyer::RainpressCompressor.new
            assert rainpress
            # check execution?
        end
    end
end

    