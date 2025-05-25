import 'package:get/get.dart';
import 'package:mutazan_plus/core/utils/app_strings.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'ar_AE': {
          // App
          AppStrings.appName: 'متزان',

          // General
          AppStrings.ok: 'حسنًا',
          AppStrings.retry: 'إعادة المحاولة',
          AppStrings.yesConfirm: 'نعم، أكّد',
          AppStrings.search: 'بحث',
          AppStrings.searchHint: 'أدخل نص البحث...',

          // Auth & Onboarding
          AppStrings.welcome: 'مرحبًا',
          AppStrings.username: 'اسم المستخدم',
          AppStrings.password: 'كلمة المرور',
          AppStrings.forgotPassword: 'نسيت كلمة المرور؟',
          AppStrings.login: 'تسجيل الدخول',
          AppStrings.logout: 'تسجيل الخروج',
          AppStrings.signIn: 'تسجيل الدخول',
          AppStrings.signUp: 'إنشاء حساب',

          // Home / Navbar
          AppStrings.home: 'الرئيسية',
          AppStrings.companies: 'الشركات',
          AppStrings.settings: 'الإعدادات',
          AppStrings.notifications: 'الإشعارات',

          // Company
          AppStrings.noCompanies: 'لا توجد شركات',

          // Invoices
          AppStrings.invoices: 'الفواتير',
          AppStrings.pendingInvoices: 'الفواتير المعلقة',
          AppStrings.totalInvoices: 'إجمالي الفواتير',
          AppStrings.numberOfInvoices: 'عدد الفواتير',
          AppStrings.invoiceNumber: 'رقم الفاتورة',
          AppStrings.date: 'التاريخ',
          AppStrings.quantity: 'الكمية',
          AppStrings.netWeight: 'الوزن الصافي',
          AppStrings.material: 'المادة',
          AppStrings.confirmInvoice: 'تأكيد الفاتورة',
          AppStrings.confirmInvoiceQuestion:
              'هل أنت متأكد من أن هذه الفاتورة صحيحة؟',
          AppStrings.invoiceVerified: 'تم تأكيد الفاتورة',
          AppStrings.reportViolation: 'الإبلاغ عن مخالفة',
          AppStrings.alreadyVerified: 'هذه الفاتورة محققة بالفعل.',
          AppStrings.noInvoices: 'لا توجد فواتير',

          // Errors
          AppStrings.noInternet: 'لا يوجد اتصال بالإنترنت',

          // Profile / Settings
          AppStrings.language: 'اللغة',
          AppStrings.theme: 'المظهر',
          AppStrings.privacyPolicy: 'سياسة الخصوصية',
          AppStrings.phoneNumber: 'رقم الهاتف',
          AppStrings.address: 'العنوان',
          AppStrings.sanaaYemen: 'صنعاء، اليمن',
          AppStrings.email: 'البريد الإلكتروني',

          // Onboarding
          AppStrings.onboardingTitle1: 'استكشاف المخالفات بطريقة ذكية مع نظام متزان',
          AppStrings.onboardingSubtitle1:
              'باستخدام مكتبات التاريخ في تطبيقنا يمكنك العثور على العديد من الفترات التاريخية',

          AppStrings.onboardingTitle2: 'من كل مكان على وجه الأرض',
          AppStrings.onboardingSubtitle2:
              'مجموعة كبيرة من الأماكن القديمة من جميع أنحاء العالم',

          AppStrings.onboardingTitle3:
              'استخدام تقنية الذكاء الاصطناعي لتجربة أفضل',
          AppStrings.onboardingSubtitle3:
              'الذكاء الاصطناعي يقدم توصيات ويساعدك على متابعة رحلتك البحثية',

          // إضافات جديدة
          AppStrings.loginFirst: 'يرجى تسجيل الدخول أولاً',
          AppStrings.biometricAuthFailed: 'فشل التحقق بالبصمة',
          AppStrings.active: 'نشط',
          AppStrings.inactive: 'غير نشط',
          AppStrings.note: 'ملحوظة',
          AppStrings.skip: 'تخطي',
          AppStrings.loginNow: 'تسجيل الدخول الآن',
          AppStrings.next: 'التالي',
          AppStrings.status: 'الحالة',
          AppStrings.footerText: '30% من الفواتير تبدو جيدة.',
          AppStrings.createAccount: 'إنشاء حساب',
          AppStrings.invoiceOptions: 'خيارات الفاتورة',
          AppStrings.chooseOption: 'اختر خيارًا',
          AppStrings.passwordRequired: 'يرجى إدخال كلمة المرور.',
          AppStrings.usernameRequired: 'يرجى إدخال اسم المستخدم.',
          AppStrings.useFingerprint: 'استخدام بصمة الإصبع للدخول',

          AppStrings.notification: 'إشعار',
          // AppStrings.notifications: 'الإشعارات',
          AppStrings.noNotifications: 'لا توجد إشعارات',
          AppStrings.minutesAgo: 'منذ %minutes دقيقة',
          AppStrings.hoursAgo: 'منذ %hours ساعة',
          AppStrings.daysAgo: 'منذ %days يوم',
        },
        'en_US': {
          // App
          AppStrings.appName: 'Mutazan',

          // General
          AppStrings.ok: 'OK',
          AppStrings.retry: 'Retry',
          AppStrings.yesConfirm: 'Yes, Confirm',
          AppStrings.search: 'Search',
          AppStrings.searchHint: 'Enter search text...',

          // Auth & Onboarding
          AppStrings.welcome: 'Welcome!',
          AppStrings.username: 'Username',
          AppStrings.password: 'Password',
          AppStrings.forgotPassword: 'Forgot Password?',
          AppStrings.login: 'Login',
          AppStrings.logout: 'Logout',
          AppStrings.signIn: 'Sign In',
          AppStrings.signUp: 'Sign Up',

          // Home / Navbar
          AppStrings.home: 'Home',
          AppStrings.companies: 'Companies',
          AppStrings.settings: 'Settings',
          AppStrings.notifications: 'Notifications',

          // Company
          AppStrings.noCompanies: 'No Companies',

          // Invoices
          AppStrings.invoices: 'Invoices',
          AppStrings.pendingInvoices: 'Pending Invoices',
          AppStrings.totalInvoices: 'Total Invoices',
          AppStrings.numberOfInvoices: 'Number of Invoices',
          AppStrings.invoiceNumber: 'Invoice Number',
          AppStrings.date: 'Date',
          AppStrings.quantity: 'Quantity',
          AppStrings.netWeight: 'Net Weight',
          AppStrings.material: 'Material',
          AppStrings.confirmInvoice: 'Confirm Invoice',
          AppStrings.confirmInvoiceQuestion:
              'Are you sure this invoice is correct?',
          AppStrings.invoiceVerified: 'Invoice Confirmed',
          AppStrings.reportViolation: 'Report Violation',
          AppStrings.alreadyVerified: 'This invoice is already verified.',
          AppStrings.noInvoices: 'No Invoices',

          // Errors
          AppStrings.noInternet: 'No internet connection',

          // Profile / Settings
          AppStrings.language: 'Language',
          AppStrings.theme: 'Theme',
          AppStrings.privacyPolicy: 'Privacy Policy',
          AppStrings.phoneNumber: 'Phone Number',
          AppStrings.address: 'Address',
          AppStrings.sanaaYemen: 'Sanaa, Yemen',
          AppStrings.email: 'Email',

          // Onboarding
          AppStrings.onboardingTitle1: 'Explore history smartly with Dalel',
          AppStrings.onboardingSubtitle1:
              'Using our app’s history libraries you can find many historical periods',

          AppStrings.onboardingTitle2: 'From every place on Earth',
          AppStrings.onboardingSubtitle2:
              'A big variety of ancient places from all over the world',

          AppStrings.onboardingTitle3:
              'Leverage modern AI for a better experience',
          AppStrings.onboardingSubtitle3:
              'AI provides recommendations and helps you continue your search journey',

          // إضافات جديدة
          AppStrings.loginFirst: 'Please login first',
          AppStrings.biometricAuthFailed: 'Biometric authentication failed',
          AppStrings.active: 'Active',
          AppStrings.inactive: 'Inactive',
          AppStrings.note: 'Note',
          AppStrings.skip: 'Skip',
          AppStrings.loginNow: 'Login Now',
          AppStrings.next: 'Next',
          AppStrings.status: 'Status',
          AppStrings.footerText: '30% of the invoices look good.',
          AppStrings.createAccount: 'Create Account',
          AppStrings.invoiceOptions: 'Invoice Options',
          AppStrings.chooseOption: 'Choose Option',
          AppStrings.passwordRequired: 'Please enter your password.',
          AppStrings.usernameRequired: 'Please enter username.',
          AppStrings.useFingerprint: 'Use fingerprint to login',

          AppStrings.notification: 'Notification',
          // AppStrings.notifications: 'Notifications',
          AppStrings.noNotifications: 'No notifications',
          AppStrings.minutesAgo: '%minutes minutes ago',
          AppStrings.hoursAgo: '%hours hours ago',
          AppStrings.daysAgo: '%days days ago',
        },
      };
}
