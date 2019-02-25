class User < ActiveRecord::Base
	has_many :blogs,  dependent: :destroy
	belongs_to :department
	has_many :comments,  dependent: :destroy
	has_one :likes,  dependent: :destroy
	has_one_attached :profile_image
	LIST = Department.all.collect {|c| [ c.department_name, c.id ]}
	validates :user_name,presence: true,length:{minimum: 3,maximum: 25},uniqueness:true;
	validates :email,presence: true,length:{minimum: 10,maximum: 50},uniqueness:true;
	validates :password,presence: true,length:{minimum: 4,maximum: 10};

	before_save do
		self.email = email.downcase
	end

end