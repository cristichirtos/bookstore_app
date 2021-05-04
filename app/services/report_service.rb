class ReportService
  def export
    raise NotImplementedError, "#{self.class} has not implemented export"
  end

  def type
    raise NotImplementedError, "#{self.class} has not implemented type"
  end 

  def generate_report(books_list)
    raise NotImplementedError, "#{self.class} has not implemented generate_report"
  end
end
