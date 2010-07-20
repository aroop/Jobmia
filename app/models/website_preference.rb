class WebsitePreference < ActiveRecord::Base
	
	after_update :save_q_and_as, :save_weblinks
	
	has_one :travel_type
	has_one :us_work_authorization
	has_one :current_salary_level, :class_name => "SalaryLevel", :foreign_key => "current_salary_level_id"
	has_one :desired_salary_level, :class_name => "SalaryLevel", :foreign_key => "desired_salary_level_id"
	has_one :job_type
	has_one :relocate_option
	belongs_to :user
	has_and_belongs_to_many :weblinks
	has_and_belongs_to_many :q_and_as
	
  def q_and_a_attributes=(q_and_a_attribute)
  	q_and_a_attribute.each do |key, value|
  		q_and_a = q_and_as.detect {|t| t.id == key.to_i}
  		q_and_a.update_attributes(value)
  	end
  end
		
	def save_q_and_as
		q_and_as.each { |q_and_a| q_and_a.save(false) }
	end
	
  def weblink_attributes=(weblink_attribute)
  	weblink_attribute.each do |key, value|
  		weblink = weblinks.detect {|t| t.id == key.to_i}
  		weblink.update_attributes(value)
  	end
  end
		
	def save_weblinks
		weblinks.each { |weblink| weblink.save(false) }
	end

end