class Url < ApplicationRecord

	validates_presence_of :main_url
  validates :main_url, format: URI::regexp(%w[http https])

	before_create :generate_small_url

	def generate_small_url
		self.small_url = rand(36**8).to_s(36)
	end

end
