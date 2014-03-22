module ApplicationHelper

  # Returns the full title on a per-page basis.
  def full_title(page_title)          #Method definition.
     base_title = "My Sample Application Under Rails"  #Variable assignment
     if page_title.empty?   #boolean test
	base_title          #Implicit return 
     else 
	"#{base_title} | #{page_title}"  #String interpolation 
     end 
   end 
end
