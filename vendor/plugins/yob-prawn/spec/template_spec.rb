require File.join(File.expand_path(File.dirname(__FILE__)), "spec_helper")

describe "Document built from a template" do

  it "should have the same page count as the source document" do
    filename = "#{Prawn::BASEDIR}/reference_pdfs/curves.pdf"

    @pdf = Prawn::Document.new(:template => filename)

    page_counter = PDF::Inspector::Page.analyze(@pdf.render)
    page_counter.pages.size.should == 1
  end

  it "should not add an extra restore_graphics_state operator to the end of any content stream" do
    filename = "#{Prawn::BASEDIR}/reference_pdfs/curves.pdf"

    @pdf = Prawn::Document.new(:template => filename)
    output = StringIO.new(@pdf.render)
    hash = PDF::Hash.new(output)

    hash.each_value do |obj|
      next unless obj.kind_of?(PDF::Reader::Stream)

      data = obj.data.tr(" \n\r","")
      data.include?("QQ").should == false
    end

  end

  it "should have two content streams after importing a single page template" do
    filename = "#{Prawn::BASEDIR}/reference_pdfs/curves.pdf"

    @pdf = Prawn::Document.new(:template => filename)
    output = StringIO.new(@pdf.render)
    hash = PDF::Hash.new(output)

    hash.values.select { |obj|
      obj.kind_of?(PDF::Reader::Stream)
    }.size.should == 2
  end

  it "should allow text to be added to a single page template" do
    filename = "#{Prawn::BASEDIR}/data/pdfs/hexagon.pdf"

    @pdf = Prawn::Document.new(:template => filename)

    @pdf.text "Adding some text"

    text = PDF::Inspector::Text.analyze(@pdf.render)
    text.strings.first.should == "Adding some text"
  end

  it "should allow text to be added to a multiple page template" do
    filename = "#{Prawn::BASEDIR}/data/pdfs/two_hexagons.pdf"

    @pdf = Prawn::Document.new(:template => filename)

    @pdf.text "Adding some text"
    @pdf.go_to_page(2)
    @pdf.text "Adding some more text"

    text = PDF::Inspector::Text.analyze(@pdf.render)
    text.strings[0].should == "Adding some text"
    text.strings[1].should == "Adding some more text"
  end

  it "should allow PDFs with page resources behind an indirect object to be used as templates" do
    filename = "#{Prawn::BASEDIR}/data/pdfs/resources_as_indirect_object.pdf"

    @pdf = Prawn::Document.new(:template => filename)

    @pdf.text "Adding some text"

    text = PDF::Inspector::Text.analyze(@pdf.render)
    all_text = text.strings.join("")
    all_text.include?("Adding some text").should == true
  end

  it "should copy the PDF version from the template file" do
    filename = "#{Prawn::BASEDIR}/data/pdfs/version_1_6.pdf"

    @pdf = Prawn::Document.new(:template => filename)
    str = @pdf.render
    str[0,8].should == "%PDF-1.6"
  end

  it "should correctly add a TTF font to a template that has existing fonts" do
    filename = "#{Prawn::BASEDIR}/data/pdfs/contains_ttf_font.pdf"
    @pdf = Prawn::Document.new(:template => filename)
    @pdf.font "#{Prawn::BASEDIR}/data/fonts/Chalkboard.ttf"
    @pdf.move_down(40)
    @pdf.text "Hi There"

    output = StringIO.new(@pdf.render)
    hash = PDF::Hash.new(output)

    page_dict = hash.values.detect{ |obj| obj.is_a?(Hash) && obj[:Type] == :Page }
    resources = page_dict[:Resources]
    fonts = resources[:Font]
    fonts.size.should == 2
  end

end
