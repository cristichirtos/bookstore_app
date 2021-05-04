class PDFReportService < ReportService
  def export
    "I'm a PDF reporter."
  end

  def type
    :pdf
  end 

  def generate_report(books_list)
    pdf = Prawn::Document.new
    books_list.each do |book|
      pdf.text "Book with id: #{book.id}"
      pdf.text "Title: #{book.title}"
      pdf.text "Author: #{book.author}"
      pdf.text "Description: #{book.description[0..255]}#{'...' if book.description.length > 255}"
      pdf.text "Genre: #{book.genre}"
      pdf.text "Publisher: #{book.publisher}"
      pdf.text "Published date: #{book.publishing_date}"
      pdf.text "Price: #{book.price}"
      pdf.stroke_horizontal_rule
    end

    pdf.render
  end
end
    