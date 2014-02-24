module ApplicationHelper
	# Returns the full title on a per-page basis

	def full_title(page_title)
		base_title = "WPCC Occupational Health and Safety Document Management System"
		if page_title.empty?
			base_title
		else
			"#{base_title} | #{page_title}"
		end
	end
	
	def getLiteral(key)
		return key.html_safe + "->key"
	end
	
	def long_one_line_text (name, default_value, alt)
		s= '<table cellspacing="0" cellpadding="0" title="' + alt + '">'
		
		s = s + '<tr><td>'
		s += image_tag ("icons/pencil.gif")
		s += '</td>'
		
		s = s + '<td><input type="text" name="' + name + '"  value="' + default_value + '" size="50"/></td></tr></table>'
		return s.html_safe
	end
	
	def getLink(key)
		return key + ""
	end
	

	def current_language_id()
		return ApplicationHelper.current_language_id()
	end
	def self.current_language_id()
		locale = I18n.locale
		if locale == nil
			locale = Language.first.locale
		end		
		
		lang = Language.where ("locale='" + locale.to_s + "'")
		if lang == nil
			return Language.supported_languages.first.id
		else
			return lang.first.id
		end
	end
	def current_language()
		l = Language.find (current_language_id)
		if l == nil
			return Language.first
		else
			return l
		end		
	end
	def show_header()
		res = true
		exclude_pages = ["/users/new", "/"]
		exclude_pages.each do |e|
			if request.fullpath.include?(e)
				 res = false 
			end
		end
		return res
	end

	#special encode function
	def self.encode(str)		
	  #take this string and break it into a numeric sequence
	  new_str = ""
	  #take the ordinal of a character and add 1 to it, and then read the character for that number
	  str.chars.each do |c|
		  if c == '~'
			new_str += '0'
		  else		  
		        new_str += (c.ord  + 1).chr  
		  end
	  end
	  return new_str
	end
	
	def self.decode(str)
	  new_str = ""
	  str.chars.each do |c|
	    if c == '0'
		    new_str += '~'
	    else
	    	    new_str += (c.ord - 1).chr
	    end 		    
	  end
	  return new_str
	end
end
