class EndPoint {
  static String baseUrl = "http://192.168.129.209:8000";
  // static String baseUrl = "http://192.168.130.162:8000";
  // static String baseUrl = "http://192.168.8.197:8000";

  static const String apiPrefix = "/api";

  // تسجيل الدخول
  static const String signIn = "$apiPrefix/login/";

  // الشركات (عرض )
  static const String companies = "$apiPrefix/companies/";
  // الفواتير
  static String invoices = "$apiPrefix/invoices";
  
  
  // جديد: إبلاغ مخالفة
  static String reportInvoice(int id) => "$apiPrefix/invoices/$id/report/";
  
  // جديد: تأكيد فاتورة
  // static String verifyInvoice(int id) => "$apiPrefix/invoices/$id/verify/";
}

class ApiKey {
  static String id = "id";
  static String schemaName = "schema_name";
  static String companyName = "company_name";
  static String businessType = "business_type";
  static String registrationNumber = "registration_number";
  static String phoneNumber = "phone_number";
  static String logo = "logo";
  static String employeesCount = "employees_count";
  static String foundedDate = "founded_date";
  static String servicesOffered = "services_offered";
  static String portLicenseNumber = "port_license_number";
  static String createdAt = "created_at";
  static String adminUser = "admin_user";
  static String name = "name";
  static String active = "active";
  static String country = "country";
  static String username = "username";
  static String email = "email";
  static String address = "address";
  static String street = "street";
  static String company = "company";
  static String companys = "companys";
  static String status = "status";
  static String errorMessage = "ErrorMessage";
  static String detail = "detail";
  static String password = "password";
  static String token = "token";
  static String refreshToken = "refreshToken";
  static String accessToken = "accessToken";
  static String access = "access";
  static String refresh = "refresh";
  //Invoices
  static String xSchema = "x-schema";
  static String invoiceId = "id";
  static String weightCard = "weight_card";
  static String material = "material";
  static String quantity = "quantity";
  static String datetime = "datetime";
  static String netWeight = "net_weight";
}
