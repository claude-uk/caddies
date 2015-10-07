#rake_shared_methods.rb
#generic methods used in the rake modules
#it is a temporary measure while we use 'puts' instead of rendering with the views in the rake output
#this will happen whenever we update the ror version
#I cannot use cgi.escapeHTML because the metadata team has already used escape patterns which would be protected

module RakeGenerics

	#replace the occurences of & with &amp; if there are any
	#\b is for word boundary
	def safeputs(sentence)
	  #puts sentence
	  #puts sentence.gsub(/\b\&\b/, '&amp;')
	  puts sentence.gsub(' & ', ' &amp; ')
	end

end