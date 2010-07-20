class ResumesController < ApplicationController
	include DownloadHelper

  def index
    if logged_in?
      @user = current_user
    else
      redirect_to root_path
    end
  end
  
  def edit
    if logged_in?
    	user = User.find(current_user)
    	unless user.active_resume.nil?
  	    @resume = Resume.find(user.active_resume)
  	    @section_types = unused_section(@resume)
  	    @resume_styles = ResumeStyle.find(:all)
      else
      	flash[:error] = "You do not have any resumes. Please first create a resume"
      	redirect_to :action => 'index'
    	end  	
    else
      redirect_to builder_path
    end
  end
  
  def designer
    if logged_in?
      user = current_user
    	unless user.active_resume.nil?
  	    @resume = Resume.find(user.active_resume)
  	    @resume_styles = ResumeStyle.find(:all)
  	    @resume_content = get_formatted_resume(@resume, "html")
  	    render :layout => 'preview'
      else
      	flash[:error] = "You do not have any resumes. Please first create a resume"
      	redirect_to :action => 'index'
    	end  	
    else
      redirect_to designer_path
    end    
  end

  def create
    @resume = Resume.new
    @resume.name = params[:resume_name]
    current_user.resumes << @resume
    flash[:notice] = "Resume created successfully"
    @resume.reload
    @resume.sections << create_section("Personal Details")
    @resume.sections << create_section("Work Experience")
    @resume.sections << create_section("Skills")
		@resume.sections << create_section("Education")
		@resume.sections << create_section("Objective")
		@resume.sections << create_section("References")
    respond_to do |format|
    	format.html { redirect_to :controller => 'home' }
    	format.js
    end
  end
  
  def destroy
  	@resume = Resume.find(params[:id])
    @resume.destroy
    delete_exported_resumes(@resume)
    @resume.user.resumes.reload
    flash[:notice] = 'Resume deleted successfully.'
    respond_to do |format|
    	format.html { redirect_to :controller => 'home' }
    	format.js 
    end
  end
  
  def preview
  	@resume_content = get_formatted_resume(Resume.find(params[:id]), "html")
  	render :layout => false
  end
  
  def add_entry
  	@section = Section.find(params[:id])
  	@entry = Entry.new
  	@section.entries << @entry
  	@section.resume.resume_updated
  	if (@section.name == "References")
  		@entry.address = Address.new
		end
  end
  
  def remove_entry
  	@entry = Entry.find(params[:id])
  	@entry.section.resume.resume_updated
  	if (@entry.section.entries.size > 1)
	  	@entry.destroy
	  	flash[:notice] = 'Entry deleted successfully.'
	    respond_to do |format|
	    	format.js
    	end
    else
	  	@entry = Entry.find(params[:id])
	  	@section = @entry.section
	  	@resume = @section.resume
	  	@section.destroy
	  	flash[:notice] = 'Section deleted successfully.'
	  	@section_types = unused_section(@resume)
    	render :action => "remove_section"
  	end
  end
  
  def save_entry
  	@entry = Entry.find(params[:id])
  	@entry.update_attributes(params[:entry])
  	@entry.section.resume.resume_updated
  end
  
  def add_section
  	@resume = Resume.find(params[:id])
  	section_name = params[:section_name]
  	if(section_name != "")
	  	@section = create_section(section_name)
	  	@resume.sections << @section
	  	@section_types = unused_section(@resume)
	  	@resume.resume_updated
  	end
  end
  
  def remove_section
  	@section = Section.find(params[:id])
  	@resume = @section.resume
  	@section.destroy
  	@resume.resume_updated
  	flash[:notice] = 'Section deleted successfully.'
  	@section_types = unused_section(@resume)
  end
  
  def make_active
  	@resume = Resume.find(params[:id])
  	@resume.activate
  	@resume.reload
  end
  
  def order_section
	  params[:container].each_with_index { |id,idx| Section.update(id, :position => idx) }
	  render :text => ''
  end
  
  def order_entries
  	params.each do |key, value| 
  		if(key.to_s != "action" && key.to_s != "controller" && key.to_s != "id")
  			value.each_with_index { |id,idx| Entry.update(id, :position => idx) }
			end
  	end
	  render :text => ''
  end

  def distribution
    if logged_in?
    	user = User.find(current_user)
    	unless user.active_resume.nil?
  	    @resume = Resume.find(user.active_resume)
  	    render :layout => 'promotion'
      else
      	flash[:error] = "You do not have any resumes. Please first create a resume"
      	redirect_to :action => 'index'
    	end
    else
      redirect_to distributer_path
    end    
  end
  
  def promotion
    if logged_in?
    	user = User.find(current_user)
    	unless user.active_resume.nil?
  	    @job_seeker = User.find(current_user)
      else
      	flash[:error] = "You do not have any resumes. Please first create a resume"
      	redirect_to :action => 'index'
    	end
    else
      redirect_to promotion_path
    end    
  end
  
  def download
    resume = Resume.find(params[:id])
		resume_date = get_formatted_resume(resume, params[:type], (logged_in? && resume.user == current_user))
  	send_data resume_date, :type => get_output_format(params[:type]), :filename => resume.name+"."+params[:type]
  end
  
  def set_style
  	user = User.find(current_user)
  	unless user.active_resume.nil?
	    @resume = Resume.find(user.active_resume)
	    @previous_style = @resume.resume_style.id
	    @present_style = params[:id]
	    if @previous_style != @present_style
		    @resume.resume_style = ResumeStyle.find(@present_style)
		    @resume.save
	    end	    
			@resume_content = get_formatted_resume(@resume, "html")
    end
  end
  
  def email
  	user = User.find(current_user)
  	unless user.active_resume.nil?
	    @resume = Resume.find(user.active_resume)
  	end
  end
  
  def sendemail
  	user = User.find(current_user)
  	Notification.deliver_email_resume(params[:subject], params[:email], user.email, params[:notes], 
  	    get_output_format(params[:resume_type]), user.active_resume.name + "." +params[:resume_type], 
  	    @resume_content = get_formatted_resume(user.active_resume, params[:resume_type]))
  	flash[:notice] = "Email sent successfully"
  	redirect_to :action => "distribution"
  end
  
  def update_event
  	event = Event.find(params[:id])
  	event.update_attributes(params[:event])
  	render :text => ''
  end
  
  def save_options
  	resume_options = ResumeOption.find(params[:id])
    if resume_options.update_attributes(params[:resume_option])
      #flash[:notice] = "Options saved successfully"
      resume_options.resume.resume_updated
    else
    	#flash[:error] = "An error occured while saving the resume options"
  	end
  	render :text => ''
  end
  
  private
  def create_section(name)
  	if (name == "Personal Details")
  		section = PersonalDetailsSection.new
		elsif (name == "Education")
			section = EducationSection.new
		elsif (name == "Work Experience")
			section = WorkExperienceSection.new
		elsif (name == "References")
			section = ReferenceSection.new
		else
			section = GeneralSection.new
		end
		section.name = name
		section.entries.build
  	if (name == "References" || name == "Personal Details")
  		section.entries[0].address = Address.new
		end
		section
  end
  
  def unused_section(resume)
    section_types = SectionType.find(:all, :order => 'name')
  	resume.sections.each { |section| section_types = (section_types - [SectionType.find_by_name(section.name)]) }	
  	section_types
  end
  
  def delete_exported_resumes(resume)
  	formats_to_delete = [ "pdf", "doc", "txt", "html", "rtf"]
  	formats_to_delete.each do |format|
  		FileUtils.rm_rf("#{RAILS_ROOT}/public/resume/#{resume.id}.#{format}")
		end
  end
end