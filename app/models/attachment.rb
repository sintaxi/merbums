class Attachment < ActiveRecord::Base
  belongs_to :post

  before_save :move_file
  before_destroy :delete_file

  validates_presence_of :filename

  attr_accessor :content_type, :size, :tempfile
  attr_reader :title, :path

  def full_path
    Merb.root / "public" / path
  end

  def path
    "/uploads" / filename
  end

  def filename=(dirty_filename)
    write_attribute( :filename , rand(Time.now).to_s + dirty_filename.gsub(/(\ |_)/,"-").downcase.gsub(/^.*(\\|\/)/, '') )
  end

  def title
    filename.titleize.gsub(/\.\w{3,4}$/,'')
  end

  def move_file
    FileUtils.mv(tempfile.path , full_path) if FileTest.exist?(tempfile.path)
  end

  def delete_file
    if FileTest.exist?(full_path)
      FileUtils.rm(full_path)
    end
    return true
  end

end