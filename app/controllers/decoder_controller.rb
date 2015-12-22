class DecoderController < ApplicationController
	def index
		@text=Text.new(:content=>"")
	end

	def encode
		@text||=Text.new(:content=>"")
		@text.update_attributes(:content => params[:content], :shift => params[:shift])
		position=[]
		@newstr=""
		alphabet = " abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789~!@#$%^&*()_+=-`\/}{?'}{:;|\/><"
	 	@text.content.to_s.each_char {|n| x=alphabet.index(n.to_s); x+=@text.shift.to_i; position << x}
	 	position.each do |n|
	 		@newstr+=alphabet.split(//).at(n.to_i)
	 	end
	 	puts "New str #{@newstr}"
	 	respond_to do |format|
	 		format.js
	 	end
	end

	def isEncoded
		if params[:content].length>3
			respond_to do |format|
		 			format.js
		 	end
 		else
			render :index
		end		
	end

end
