class Blacksmith::TTFAutoHint < Blacksmith::Executable
  
  def executable
    'ttfautohint'
  end
  
  def execute(source)
    check_dependency!
    
    target = begin
      f = Tempfile.new(File.basename(source))
      f.close
      f.path
    end 
    
    build_hinted_font(source, target)
    replace_file(source, target)
  end
  
  private
    
    def replace_file(source, target)
      FileUtils.mv(target, source)
    end
    
    def build_hinted_font(source, target)
      args = %w{
        --hinting-limit=200
        --hinting-range-max=50
        --symbol
      }

      system(executable, *args, source, target)
    end
  
end
