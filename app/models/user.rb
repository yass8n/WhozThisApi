class User < ActiveRecord::Base
  require 'securerandom'
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :phone, presence: true
  has_many :conversations, through: :conversation_users

  	def generate_filename
		filename = SecureRandom.hex + ".jpg"
		#ensures unique filename
		while User.find_by(filename: filename) do
			filename = SecureRandom.hex + ".jpg"
		end
		return filename
	end
	def remove_image_path
		if ( !self.filename.nil? && self.filename != "")
			path = Rails.root.join('public', 'images', self.filename)
			File.delete(path)
		    self.filename = ""
		end
	end
	def create_image
        #create a new tempfile named fileupload
        tempfile = Tempfile.new("fileupload")

        tempfile.binmode
        #get the file and decode it with base64 then write it to the tempfile
        tempfile.write(Base64.decode64(params[:user][:base64Bitmap]))
        # i dunno why I need this but I saw it in an example
        tempfile.rewind()

        #create a new uploaded file
        uploaded_file = ActionDispatch::Http::UploadedFile.new(:tempfile => tempfile)

        self.filename = resource.generate_filename

      File.open(Rails.root.join('public', 'images', self.filename), 'wb') do |file|
        file.write(uploaded_file.read)
      end
	end
	def find_by_phone
	    return User.where(phone: self.phone)[0]
	end
end
