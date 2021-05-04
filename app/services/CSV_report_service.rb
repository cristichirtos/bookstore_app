require 'csv'

class CSVReportService < ReportService
  def export
    "I'm a CSV reporter."
  end

  def type
    :csv
  end 

  def generate_report(books_list)
    CSV.generate do |csv_file|
      csv_file << %w(ID Title Author Description Genre Publisher PublishingDate Price)
      books_list.each do |book|
        csv_file << [book.id, book.title, book.author, book.description, book.genre, book.publisher, book.publishing_date, book.price]
      end
    end
  end
end
