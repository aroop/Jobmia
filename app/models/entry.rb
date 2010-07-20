class Entry < ActiveRecord::Base
	belongs_to :section
	acts_as_list :scope => :section
	has_one :address, :as => :addressable, :dependent => :destroy
	
	after_update :save_address
	
	#acts_as_solr :fields => [:name], :if => proc{|entry| entry.section.class.to_s == "WorkExperienceSection" || entry.section.class.to_s == "EducationSection"}
	
	def address_attributes=(address_attributes)
		address_attributes.each do |key, value|
  		address.update_attributes(value)
  	end
	end
	
	def save_address
		unless address.nil?
			address.save(false)
		end
	end

end