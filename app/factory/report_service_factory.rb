class ReportServiceFactory
  def initialize(report_services)
    @report_services = {}
    report_services.each { |report_service| @report_services[report_service.type] = report_service }
  end

  def get_report_service(type)
    @report_services[type]
  end
end
