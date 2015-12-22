class DecoderController < ApplicationController
	def index
		@text=Text.new(:content=>"")
	end

	def encode
		@text||=Text.new(:content=>"")
		@text.update_attributes(:content => params[:content], :shift => params[:shift])
		position=[]
		@newstr=""
		alphabet ="abcdefghijklmnopqrstuvwxyz"
	 	@text.content.to_s.squish.each_char do |n|
			if " .,~!@#$%^&*()_+=-`\/}{?'}{:;|\/".include?(n)	 	 
				puts n
				position<<n
			else	
		 		x=alphabet.index(n.downcase.to_s)
		 		x+=@text.shift.to_i if x
		 		position << x%25==0 ? x : x%25 
		 	end	
	 	end 
	 	p position
	 	puts position.length
	 	position.each do |n|
	 		if n==" " 
	 		  @newstr+=" " 
	 		else
	 		  @newstr+=alphabet.split(//).at(n.to_i)
	 		end  
	 	end
	 	puts "New str #{@newstr}"
	 	respond_to do |format|
	 		format.js
	 	end
	end

	def isEncoded
		chars_frequency=[]
		params[:content].downcase.chars.group_by(&:chr).map do |k, v|  
			chars_frequency<<[k, v.size/params[:content].length.to_f*100] 
		end
		# normal_spreading
		if params[:content].length>3
			respond_to do |format|
		 			format.js
		 	end
 		else
			redirect_to :index
		end		
	end

end
