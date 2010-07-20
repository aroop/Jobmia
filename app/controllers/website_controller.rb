class Jobseeker::WebsiteController < Jobseeker::JobseekerController

  def index
  	
  end
  
  def profile
  	@job_seeker = JobSeeker.find(current_user)
  	@website_preference = @job_seeker.website_preference
  	@us_work_authorizations = UsWorkAuthorization.find(:all, :order => "id")
  	@job_types = JobType.find(:all, :order => "id")
  	@travel_types = TravelType.find(:all, :order => "id")
  	@salary_levels = SalaryLevel.find(:all, :order => "id")
  	@relocate_options = RelocateOption.find(:all, :order => "id")
  	@sample_questions = SampleQuestion.find(:all, :order => "id")
  	@sample_links = SampleWeblink.find(:all, :order => "id")
  end
  
  def update_profile
  	@job_seeker = JobSeeker.find(current_user)
  	if @job_seeker.website_preference.update_attributes(params[:website_preference])
	  	flash[:notice] = 'Profile successfully saved.'
  	else
  		flash[:error] = 'Error occurured while saving profile.'
  	end
  	redirect_to :controller => 'website', :action => 'profile'
  end
  
  def promotion
  	@job_seeker = JobSeeker.find(current_user)
  end
  
  def overview
  	
  end
  
  def add_question_answer
  	@sample_questions = SampleQuestion.find(:all, :order => "id")
  	website_preference = WebsitePreference.find(params[:id])
  	@q_and_a = QAndA.new
  	website_preference.q_and_as << @q_and_a
  end
  
  def remove_question_answer
  	@q_and_a = QAndA.find(params[:id])
  	@q_and_a.destroy
  	flash[:notice] = 'Deleted successfully.'
    respond_to do |format|
    	format.js
    end
  end
  
  def add_weblink
  	@sample_links = SampleWeblink.find(:all, :order => "id")
  	website_preference = WebsitePreference.find(params[:id])
  	@weblink = Weblink.new
  	website_preference.weblinks << @weblink  	
  end
  
  def remove_weblink
  	@weblink = Weblink.find(params[:id])
  	@weblink.destroy
  	flash[:notice] = 'Deleted successfully.'
    respond_to do |format|
    	format.js
    end  	
  end
  
end