class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

	ROLES = %w[admin coordinator staff guest]
	
  # Setup accessible (or protected) attributes for your model
  attr_accessor :current_password
  attr_accessible :email, :password, :password_confirmation, :remember_me,:current_password
  attr_accessible :role_id, :db_id, :role
  
	def self.to_csv(params)
		@records = User.metasearch(params[:search])
			CSV.generate(col_sep: "\t") do |csv|
			csv << column_names
			@records.each do |f|
				csv << f.attributes.values_at(*column_names)
			end
		end
	end

  
end
