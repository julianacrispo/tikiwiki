module ApplicationHelper

	def markdown(text)
	  renderer = Redcarpet::Render::HTML.new
	  extensions = {
	  	fenced_code_blocks: true, 
	  	autolink: true, 
	  	lax_spacing: true, 
	  	footnotes: true, 
	  }
	  redcarpet = Redcarpet::Markdown.new(renderer, extensions)
	  (redcarpet.render text).html_safe
	end
end
