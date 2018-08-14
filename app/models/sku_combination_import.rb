class SkuCombinationImport 
	include ActiveModel::Model
	include ActiveModel::Validations

  FILE_ROOT = "public/files"
  attr_accessor :file, :sku_no
  validates_presence_of :file, :sku_no
  validates_numericality_of :sku_no

  def initialize(attributes = {})
    @file = attributes[:file]
    @sku_no = attributes[:sku_no].to_i
  end

  def persisted?
    false
  end

  def save
    if imported_sku_combinations.compact.map(&:valid?).all?
      imported_sku_combinations.compact.each(&:save!)
      UserMailer.success_mail().deliver_now    
      true
    else
    	errors_msg = []
      imported_sku_combinations.compact.each_with_index do |sku_combination, index|
        sku_combination.errors.full_messages.each do |message|
         errors_msg << ["Row #{index+2}: #{message}"]
        end
      end
      UserMailer.error_mail(errors_msg.join(", ")).deliver_now      
      false
    end
  end

  def imported_sku_combinations
    @imported_sku_combinations ||= load_imported_sku_combinations
  end

  def load_imported_sku_combinations
    spreadsheet = Roo::Spreadsheet.open(@file)
    header = spreadsheet.row(1)
    sku_combinations = []
    (2..spreadsheet.last_row).each do |i|
      first_val = spreadsheet.row(i).first
      (2..spreadsheet.last_row).each do |index|
       sku_combination = SkuCombination.new(sku_denomination: @sku_no, sku_combination: "#{first_val}, #{select_columns(spreadsheet, index) }") unless spreadsheet.row(index)[1].blank?
       sku_combinations << sku_combination
      end
    end
    sku_combinations
  end

  def select_columns(spreadsheet, index)
  	value = []
  	(1...spreadsheet.row(1).length).each do | col_index |
  		i = index
	  	while(i>=2)
	  		if i==2
	  			value<<spreadsheet.row(i)[col_index]
	  			break
	  		elsif spreadsheet.row(i)[col_index].blank?
	  			i=i-1
	  		else
	  			value<<spreadsheet.row(i)[col_index]
	  			i=i-1
	  			break
	  		end
	  	end
	  end
  	value.join(", ")
  end

  def self.save_file(upload, sku_no)
    file_name = upload.original_filename  
    file = upload.read    
    new_file_name_with_type = "#{file_name}#{Time.now.to_i}." + file_name.split('.').last
    File.open("#{FILE_ROOT}/" + new_file_name_with_type, "wb")  do |f|  
      f.write(file) 
    end
    # self.process_file_data("#{FILE_ROOT}/" + new_file_name_with_type, sku_no)
    self.delay(run_at: 5.minutes.from_now).process_file_data("#{FILE_ROOT}/" + new_file_name_with_type, sku_no)
  end

  def self.process_file_data(file_path, sku_no)
  	sku_combination = SkuCombinationImport.new(file_path, sku_no)
    sku_combination.save
  end

  def self.open_spreadsheet(file)
    case File.extname(file.original_filename)
    when ".csv" then Csv.new(file.path, nil, :ignore)
    when ".xls" then Excel.new(file.path, nil, :ignore)
    when ".xlsx" then Excelx.new(file.path, nil, :ignore)
    else raise "Unknown file type: #{file.original_filename}"
    end
  end

end