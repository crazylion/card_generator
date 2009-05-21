pdf.image(File.join(Rails.root,"public",@card.cover.url(:A6,false)),:width=> pdf.bounds.width,:height=> pdf.bounds.height)
pdf.font "#{Rails.root}/fonts/wt014.ttf"  
# pdf.text "#{Prawn::BASEDIR}", :size => @font_size
# pdf.text "width:#{pdf.bounds.width}"
# pdf.text "height:#{pdf.bounds.height}"
if  @card.back.file? 
	pdf.start_new_page
	pdf.image(File.join(Rails.root,"public",@card.back.url(:A6,false)),:width=> pdf.bounds.width,:height=> pdf.bounds.height)
else
	pdf.start_new_page(:left_margin=>10,:right_margin=>10,:bottom_margin=>10,:top_margin=>10)
	pdf.text "#{@card.title}",:size=>@font_size+6,:align=>:center
	pdf.text "#{@desc}",:size=>@font_size
end
