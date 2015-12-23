class DecoderController < ApplicationController
	def index
		@text=Text.new(:content=>"")
	end

	def encode
		@text||=Text.new(:content=>"")
		@text.update_attributes(:content => params[:content], :shift => params[:shift])
		position=[]
		@newstr=""
	 	@text.content.to_s.squish.each_char do |n|
			if "\\\" .,~!@#$%^&*()_+=—-`/}{?'}{:;|[]0123456789".include?(n)	 	 
				position<<n
			else	
		 		x=alphabet.index(n.downcase.to_s)
		 		p n
		 		p x
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
	 	respond_to do |format|
	 		format.js
	 	end
	end

	def isEncoded
		clean_text=params[:content].squish.delete(" .,~!@#$%^&*()_+=-`\/}{?'}{:;|\/")
		frequency=char_frequency(clean_text)
		@shift=check_shift(normal_spreading, frequency)
		unless @shift==[]
			respond_to do |format|
		 			format.js
		 	end
 		else
			redirect_to :index
		end		
	end

	def alphabet 
		@alphabet ="abcdefghijklmnopqrstuvwxyz"
	end

	def normal_spreading
		@normal_spreading={"e"=>12.7,"t"=>9.06,"a"=>8.17,
											"o"=>7.51,"i"=>6.97,"n"=>6.75
											}.sort_by {|_key, value| value}
	end

	def char_frequency(text)
		chars_frequency=[]
		text.downcase.chars.group_by(&:chr).map do |k, v|  
			value=v.size/text.length.to_f*100
			chars_frequency<<[k, value.round(2)] 
		end
		chars_frequency.sort_by! {|_key, value| value}
	end

	def check_shift(normal,text)
		shift=[]
		norm_pos_array=[]
		intersection=0
		diff=HashDiff.diff(normal.last(6).to_h, text.last(6).to_h )
		diff.map{|diff_value| intersection+=1 if diff_value[0]=="~"}
		normal.map{|e| norm_pos_array<<alphabet.index(e[0])}
		if intersection<3
			text_pos_array=[]
			text.last(6).each do |e|
				text_pos_array<<alphabet.index(e[0])
			end	
			p text_pos_array
			for i in 0..25 do
				compare_array=text_pos_array.map {|e| e+=i;e=e%26}
				if(norm_pos_array-compare_array).count<3
					shift=26-i
				end	
			end	
		end	
		return shift
	end	

end
