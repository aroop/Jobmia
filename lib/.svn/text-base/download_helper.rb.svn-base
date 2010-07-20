require 'rubygems'
require 'ruport'
require 'documatic'
require 'ruport/extensions'

module DownloadHelper 

	def get_formatted_resume(resume, format, private_resume = true)
		resume_content = nil
		if resume.has_fresh_reports
	  	out_file = "#{RAILS_ROOT}/public/resume/#{resume.id}.#{format}"
	  	unless private_resume
	  		out_file = "#{RAILS_ROOT}/public/resume/#{resume.id}_public.#{format}"
	  	end
	  	resume_content = read_file_content(out_file)
  	else
  		if private_resume
  			resume_output = create_private_resume(resume)
			else
				resume_output = create_public_resume(resume)
  		end
  		
		  http = Net::HTTP.new('208.78.96.196', 8080)
			path = '/converter/service'
			headers = {
			  'Content-Type' => 'application/vnd.oasis.opendocument.text', 
			  'Accept' => get_output_format(format)
			}
			resp = http.post(path, resume_output, headers)
			resume_content = resp.body
			if format == 'html'
				resume_content = process_html(resume_content)
			end
		end
		resume_content
	end

  def get_output_format(extension)
  	if extension == "pdf"
  		"application/pdf"
		elsif extension == "doc"
			"application/msword"
		elsif extension == "txt"
			"text/plain"
		elsif extension == "html"
			"text/html"
		elsif extension == "rtf"
			"text/rtf"
		end
  end
  
  def process_html(resume_content)
  	resume_content = resume_content.gsub(/<HTML>/, '')
  	resume_content = resume_content.gsub(/<HEAD>/, '')
  	resume_content = resume_content.gsub(/<\/HTML>/, '')
  	resume_content = resume_content.gsub(/<\/HEAD>/, '')
  	resume_content = resume_content.gsub(/<TITLE><\/TITLE>/, '')
  	resume_content = resume_content.gsub(/<BODY LANG="en-US" DIR="LTR">/, '')
  	resume_content = resume_content.gsub(/<\/BODY>/, '')  	
  	resume_content = resume_content.gsub(/<P CLASS="western" STYLE="margin-bottom: 0in"><BR>/, '')
  	resume_content = resume_content.gsub(/<!DOCTYPE HTML PUBLIC "-\/\/W3C\/\/DTD HTML 4.0 Transitional\/\/EN">/, '')
  	resume_content = resume_content.gsub(/<META NAME="AUTHOR" CONTENT="Ajay Kumar">/, '')
  	resume_content = resume_content.gsub(/<META NAME="CHANGEDBY" CONTENT="Ajay Kumar">/, '')
  	resume_content = resume_content.gsub(/<META HTTP-EQUIV="CONTENT-TYPE" CONTENT="text\/html; charset=iso-8859-1">/, '')  	
		resume_content = resume_content.gsub(/<META NAME="GENERATOR" CONTENT="OpenOffice.org 2.3  \(Unix\)">/, '')		
  	resume_content = resume_content.gsub(/BORDER=1 BORDERCOLOR="#ffffff" CELLPADDING=2 CELLSPACING=0/, 'CELLPADDING=0 CELLSPACING=0')
  	resume_content = resume_content.gsub(/<P CLASS="sectionbreak-western"><BR><BR>/, '<P CLASS="sectionbreak-western">')
  end

  def read_file_content(file_path)	
  	counter = 1
		file_content = ""
		File.open(file_path, "r") do |infile|
      while (line = infile.gets)
          file_content = file_content+line
          counter = counter + 1
      end
  	end	
  	file_content
  end	
  
  def create_private_resume(resume)
    
  	personal_section = resume.sections.find_by_type("PersonalDetailsSection")
  	unless personal_section.nil?
  		address = personal_section.entries.find(:first).address
		end
  	Documatic.add_helper ResumeHelper 
  	output = "#{RAILS_ROOT}/public/output/tmpresume.odt"
  	options = Ruport::Controller::Options.new( 
  	    :template_file => "#{RAILS_ROOT}/app/views/resumes/#{ResumeStyle.find(resume.resume_style_id).name.downcase}.odt",
        :output_file   => output )    
		Documatic::OpenDocumentText::Template.process_template( :options => options,
        :data => [resume.sections, address] )    
		read_file_content(output)
  end
  
  def create_public_resume(resume)	
  	personal_section = resume.sections.find_by_type("PersonalDetailsSection")
  	unless personal_section.nil?
  		address = set_address_values(resume.resume_option, Address.new, personal_section.entries.find(:first).address)  		  		
		end
	  Documatic.add_helper ResumeHelper 
	  output = "#{RAILS_ROOT}/public/output/tmpresume.odt"
  	options = Ruport::Controller::Options.new( 
  	    :template_file => "#{RAILS_ROOT}/app/views/resumes/#{ResumeStyle.find(resume.resume_style_id).name.downcase}.odt",
        :output_file   => output )
		Documatic::OpenDocumentText::Template.process_template( :options => options,
        :data => [resume.sections, address] )
		read_file_content(output)		
	end
	
	def set_address_values(options, address, address_values)
  	options.address_1? ? address.address_1 = address_values.address_1 : address.address_1 = "" 
  	options.address_2? ? address.address_2 = address_values.address_2 : address.address_2 = "" 
  	options.city? ? address.city = address_values.city : address.city = "" 
  	options.state? ? address.state = address_values.state : address.state = "" 
  	options.postal_code? ? address.postal_code = address_values.postal_code : address.postal_code = "" 
  	options.country? ? address.country = address_values.country : address.country = "" 
  	options.phone_number? ? address.phone_number = address_values.phone_number : address.phone_number = "" 
  	options.fax_number? ? address.fax_number = address_values.fax_number : address.fax_number = "" 
  	options.email? ? address.email = address_values.email : address.email = "" 
  	options.website? ? address.website = address_values.website : address.website = "" 
  	address
	end

end