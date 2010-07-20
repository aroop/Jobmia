module ResumeHelper
	
	def get_event_heading(classname)
		case classname
	    when "PersonEvent"
	    	"Resume sent in person"
	    when "FaxEvent"
	    	"Resume sent by fax"
	    when "MailEvent"
	    	"Resume sent by mail"
	    when "WebsiteEvent"
	    	"Resume posted through website"
	    when "InternalEmailEvent"
	    	"Resume sent by email"
	    when "Contact"
	    	"Resume sent through a friend/contact"
	    when "ExternalEmailEvent"
	    	"Resume sent by email"
	  	end
		end
		
		def get_address_array(address)
			[address.address_1, address.address_2, get_string([address.city, address.state, address.postal_code, address.country]), get_string([get_phone_number(address.phone_number, true), get_fax_number(address.fax_number, true)]), get_string([address.email, address.website])]
		end
		
		def get_experience_array(entry)
			[get_string([entry.name, entry.location]), entry.title, get_dates([entry.start_date, entry.end_date], false), "", entry.details]
		end
		
		def get_education_details(entry)
			[get_string([entry.qualification, entry.specialization, entry.name]) + " "  + get_dates([entry.start_date, entry.end_date], true), "", get_gpa(entry.gpa)]
		end
		
		def get_reference_array(entry)
			[get_string([entry.name, entry.title]), entry.department, entry.organization, entry.address.email, get_phone_number(entry.address.phone_number, false), get_fax_number(entry.address.fax_number, false), entry.address.address_1, entry.address.address_2, get_string([entry.address.city, entry.address.state]), get_string([entry.address.postal_code, entry.address.country]), entry.details]
		end
		
	def get_studies(array)
		array.each do |element| 
			if element.nil? || element.chomp.blank? 
				array.delete(element) 
			end
		end
		array.join(" in ")
	end
		
	def get_dates(array, with_bracket = false)
		array.delete_if { |element| element.nil? || element.chomp.blank? }
		if with_bracket && array.size > 0
			"(" + array.join(" - ") + ")"
		else
			array.join(" - ")
		end
	end
		
	def get_gpa(gpa)
		unless gpa.nil? || gpa.chomp.blank? 
			gpa + " Grade Point Average"
		end
	end
		
		
		def get_string(array)
			array.delete_if { |element| element.nil? || element.chomp.blank? }
			array.join(", ")
		end
		
		def get_phone_number(phone_number, basic = true)
			unless phone_number.blank?
				if basic
					phone_number.concat(" (ph)")
				else
					"tel: ".concat(phone_number)
				end
			end
		end
		
		def get_fax_number(fax_number, basic = true)
			unless fax_number.blank?
				if basic
					fax_number.concat(" (fax)")
				else
					"fax: ".concat(fax_number)
				end
			end
		end

end