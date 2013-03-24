class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_accessible :role_id
  
  def self.search(search)
		if search
			return find(:all, :conditions => ['email LIKE ? or role_id LIKE ?', "%#{search}%","%#{search}%"])
		else
			return find(:all)
		end
	end
	def self.to_csv(params)
		@records = User.search(params[:search])
			CSV.generate(col_sep: "\t") do |csv|
			csv << column_names
			@records.each do |f|
				csv << f.attributes.values_at(*column_names)
			end
		end
	end

  
end
