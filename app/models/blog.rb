class Blog < ActiveRecord::Base
  belongs_to :user
  belongs_to :department
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_one_attached :blog_image
  LIST = Department.all.collect {|c| [ c.department_name, c.id ]}
  validates :title, presence: true, length:{minimum:3, maximum:500}
  validates :description ,presence: true, length:{minimum:10, maximum:10000}
  validates :user_id, presence: true

  before_save :title_capital

  def title_capital
    self.title.capitalize
  end
end