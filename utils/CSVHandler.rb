require 'csv'

class CSVHandler

   def self.read_file(file)
      csv_text_file = File.read(file)
      read_text(csv_text_file)
   end

   def self.read_text(csv_text_file, col_sep = ';')
      CSV.parse(csv_text_file, :headers => true, col_sep: col_sep, header_converters: :symbol)
   end

end
