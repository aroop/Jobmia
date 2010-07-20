class Resume < ActiveRecord::Base

	after_update :save_entries
	after_create :activate
	before_create :set_default_values
	before_destroy :change_activate

  belongs_to :user
  validates_length_of       :name,    :within => 3..20

  validates_presence_of     :name
  validates_length_of       :name,    :within => 3..20

	belongs_to :resume_style
	has_one :resume_option, :dependent => :destroy
  has_many :sections, :order => "position", :dependent => :destroy  
  #has_many :events, :dependent => :destroy
  
  def has_fresh_reports
  	unless self.report_generated_at.nil?
  		return self.report_generated_at > self.updated_at
  	end
  	false
  end
  
  def resume_updated
  	Resume.update_all ["updated_at=?", Time.now], ["id=?", self] 
  end
  
  def reports_saved
  	Resume.update_all ["report_generated_at=?", Time.now], ["id=?", self] 
  end
  
  def self.find_for_export
  	find(:first, :conditions => "report_generated_at is null OR report_generated_at < updated_at")
	end
	
	def education_section
		self.sections.find(:first, :conditions => "type = \"EducationSection\"")
	end
	
	def work_experience_section
		self.sections.find(:first, :conditions => "type = \"WorkExperienceSection\"")
	end
  
  def entry=(entry_attributes)
  	entry_attributes.each do |key, value|
  		sections.each do |section|
  			ent = Entry.find(key.to_i)
  			ent.update_attributes(value)
  		end
  	end
	end
	
	def save_entries
		sections.each do |section|
  		section.entries.each { |entry| entry.save(false) }
  	end
	end
  
	def activate
		# Optimize this step
		resumes = self.user.resumes
		for resume in resumes
			Resume.update_all ["active=?", false], ["id=?", resume] 
		end
		Resume.update_all ["active=?", true], ["id=?", self] 
	end
	
	def change_activate
		# Optimize this step
		resumes = self.user.resumes
		if self.active? & (resumes.size > 1)
			for resume in resumes
				if resume.id != self.id
					resume.activate
					break
				end
			end
		end
	end
	
	def set_default_values
		self.resume_style = ResumeStyle.find(1)
		self.resume_option = ResumeOption.new
	end
		
end