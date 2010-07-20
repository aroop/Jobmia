class CreateResumes < ActiveRecord::Migration
  def self.up
    create_table :resumes do |t|
      t.string :name
      t.integer :user_id
      t.integer :resume_style_id, :null => false
      t.timestamps
      t.boolean :active, :default => true, :null => false
      t.datetime :report_generated_at
    end
    
    # There are five types of section. 
    # The super model is Section and the submodels are General, Work Experience, Reference, Personal Details and Education sections
    create_table :sections do |t|
    	t.string :type
    	t.string :name
    	t.integer :resume_id
    	t.integer :position
    end

		# All the entries are stored in the same table. It uses STI approach
		#Each entry has a position scoped by the section ID
    create_table :entries do |t|    	
    	t.integer :section_id
    	t.integer :position
    	t.datetime :last_searched_at
    	
    	#Sti Values
    	
    	#Used by Work Experience, Reference entries
    	t.text :details 
    	
    	#Used by Reference, Work Experience, Education entries
    	t.string :name

			#Used by Reference Entry
    	t.string :title, :organization, :department
    	t.integer :address_id

			#Used by Work Experience Entry
    	t.string :title, :location, :start_date, :end_date
    	t.text :details

			#Used by Education entry
    	t.string :gpa, :specialization, :qualification, :location, :start_date, :end_date
    	
    	#used by presonal details entry
    	t.string :full_name
    end
    
    create_table :section_types	do |t|
    	t.string :name
    end
    
    create_table :resume_styles do |t|
    	t.string :name
    end
    
    create_table :resume_options do |t|
    	t.integer :resume_id
    	t.boolean :address_1, :default => false, :null => false
    	t.boolean :address_2, :default => false, :null => false
    	t.boolean :city, :default => true, :null => false
    	t.boolean :state, :default => true, :null => false
    	t.boolean :postal_code, :default => true, :null => false
    	t.boolean :country, :default => true, :null => false
    	t.boolean :phone_number, :default => false, :null => false
    	t.boolean :fax_number, :default => false, :null => false
    	t.boolean :email, :default => false, :null => false
    	t.boolean :website, :default => false, :null => false
    end    
    
    # These are default section types used in the resume
    SectionType.reset_column_information
    SectionType.create :name=>"Personal Details"
    SectionType.create :name=>"Certifications"
		SectionType.create :name=>"Clubs & Organizations"
		SectionType.create :name=>"Course Work"
		SectionType.create :name=>"Community Involement"
		SectionType.create :name=>"Education"
		SectionType.create :name=>"Interests"
		SectionType.create :name=>"Keywords"
		SectionType.create :name=>"Publications"
		SectionType.create :name=>"References"
		SectionType.create :name=>"Skills"
		SectionType.create :name=>"Objective"
		SectionType.create :name=>"Research"
		SectionType.create :name=>"Summary"
		SectionType.create :name=>"Training"
		SectionType.create :name=>"Work Experience"
		SectionType.create :name=>"Awards & Honors"
		
		ResumeStyle.reset_column_information
		ResumeStyle.create :name=>"Classic"
		ResumeStyle.create :name=>"Clean"
		ResumeStyle.create :name=>"Crisp"
		ResumeStyle.create :name=>"Edge"
		ResumeStyle.create :name=>"Elegant"
		ResumeStyle.create :name=>"Modern"
		ResumeStyle.create :name=>"Plain"
		ResumeStyle.create :name=>"Polished"
		ResumeStyle.create :name=>"Professional"
		ResumeStyle.create :name=>"Royal"
  end

  def self.down
    drop_table :resumes
    drop_table :sections
    drop_table :entries
    drop_table :section_types
    drop_table :resume_styles
    drop_table :resume_options
  end

end