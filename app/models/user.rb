class User < ActiveRecord::Base
  require 'securerandom'
  require 'sendgrid-ruby'
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :password, presence: true
  validates :phone, presence: true, uniqueness: true
  has_many :conversations, through: :conversation_users
  has_many :conversation_users
  before_save :strip_phone_number

  	def generate_filename
		filename = SecureRandom.hex + ".jpg"
		#ensures unique filename
		while User.find_by(filename: filename) do
			filename = SecureRandom.hex + ".jpg"
		end
		return filename
	end
	def remove_image_path
		if ( self.filename != nil && self.filename != "")
			path = Rails.root.join('public', 'images', self.filename)
			File.delete(path)
		    self.filename = ""
		end
	end
	def create_image(filename)
        # create a new tempfile named fileupload
        tempfile = Tempfile.new("fileupload")

        tempfile.binmode
        # get the file and decode it with base64 then write it to the tempfile
        tempfile.write(Base64.decode64(filename))
        # i dunno why I need this but I saw it in an example
        tempfile.rewind()

        #create a new uploaded file
        uploaded_file = ActionDispatch::Http::UploadedFile.new(:tempfile => tempfile)

        self.filename = self.generate_filename

      File.open(Rails.root.join('public', 'images', self.filename), 'wb') do |file|
        file.write(uploaded_file.read)
      end
	end
	def find_by_phone
	    return User.where(phone: self.phone)[0]
	end
	def strip_phone_number
		if (self.phone != nil) then
	        self.phone.gsub!(")", "");
	        self.phone.gsub!("(", "");
	        self.phone.gsub!(" ", "");
	        self.phone.gsub!("-", "");
	        self.phone.gsub!("/", "");
	        self.phone.sub!(/^1/, ''); #if it starts with a 1, remove it
	    end
	end
	def send_text(phone, carrier, client, conv_title)
		mail = SendGrid::Mail.new do |m|
			m.to = phone+carrier
			m.subject = conv_title
			m.from = 'anonymous_user@WhozThis.com'
			m.text = 'Hey! Someone has sent you an anonymous message. Download the app "WhozThis" to view it!'
		end
		client.send(mail) 
    end
end
