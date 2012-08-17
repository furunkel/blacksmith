class Blacksmith::TTF::FontReader
  
  Header = Struct.new(:major_version, :minor_version, :number_of_tables, :search_range, :entry_selector, :range_shift, :table_directory)
  TableDirectoryEntry = Struct.new(:tag, :check_sum, :offset, :length)
  
  def initialize(font = Font)
    @font = font
  end
  
  def read(data)
    @data = data
    
    header = read_header
    tables = read_tables(header)
    
    assemble_font(header, tables)
  end
  
  protected
    
    attr_reader :font
    attr_reader :data
  
  private
  
    def read_header
      header = Header.new(*data.read(12).unpack("n6"))
      
      header.table_directory = 0.upto(header.number_of_tables - 1).map do |index|
        TableDirectoryEntry.new(*data.read(16).unpack("a4N3"))
      end
      
      header
    end
    
    def read_tables(header)
      header.table_directory.map do |entry|
        ::Blacksmith::TTF::TableReader.new.read
      end
    end
    
    def assemble_font(header, tables)
      font = self.font.kind_of?(Class) ? self.font.new : self.font
      
      font.major_version  = header.major_version
      font.minor_version  = header.minor_version
      font.search_range   = header.search_range
      font.entry_selector = header.entry_selector
      font.range_shift    = header.range_shift
      
      tables.each { |t| font << t }
      
      font
    end
  
end