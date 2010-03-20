# encoding: utf-8
#
# This sample demonstrates the use of the :template option when generating
# a new Document. The template PDF file is imported into a new document.

require "#{File.dirname(__FILE__)}/../example_helper.rb"

pdf = Prawn::Document.new
pdf.fill_color "ff0000"
pdf.fill_polygon [100, 250], [200, 300], [300, 250],
                 [300, 150], [200, 100], [100, 150]            

pdf.start_new_page
pdf.fill_color "00ff00"
pdf.fill_polygon [100, 250], [200, 300], [300, 250],
                 [300, 150], [200, 100], [100, 150]            

pdf.go_to_page(0)
pdf.fill_color "0000ff"
pdf.fill_polygon [200, 350], [300, 400], [400, 350],
                 [400, 250], [300, 200], [200, 250]            

pdf.render_file "goto.pdf"
