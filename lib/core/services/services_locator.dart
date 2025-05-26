import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';

import 'package:mutazan_plus/core/connection/network_info.dart';
import 'package:mutazan_plus/core/databases/api/api_consumer.dart';
import 'package:mutazan_plus/core/databases/api/dio_consumer.dart';
import 'package:mutazan_plus/core/databases/cache/cache_helper.dart';

// Auth
import 'package:mutazan_plus/features/auth/data/repositories/user_repository.dart';
import 'package:mutazan_plus/features/auth/presentation/cubit/user_cubit.dart';

// Company
import 'package:mutazan_plus/features/company/data/datasources/company_local_data_source.dart';
import 'package:mutazan_plus/features/company/data/datasources/company_remote_data_source.dart';
import 'package:mutazan_plus/features/company/data/repositories/company_repository_impl.dart';
import 'package:mutazan_plus/features/company/domain/repositories/company_repository.dart';
import 'package:mutazan_plus/features/company/domain/usecases/get_company.dart';
import 'package:mutazan_plus/features/company/presentation/cubit/company_cubit.dart';

// Invoice
import 'package:mutazan_plus/features/invoice/data/datasources/invoice_local_data_source.dart';
import 'package:mutazan_plus/features/invoice/data/datasources/invoice_remote_data_source.dart';
import 'package:mutazan_plus/features/invoice/data/repositories/invoice_repository_impl.dart';
import 'package:mutazan_plus/features/invoice/domain/repositories/invoice_repository.dart';
import 'package:mutazan_plus/features/invoice/domain/usecases/get_invoices.dart';
import 'package:mutazan_plus/features/invoice/domain/usecases/verify_invoice.dart';
import 'package:mutazan_plus/features/invoice/presentation/cubit/invoice_cubit.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  // -------- Core & Cache --------
  getIt.registerLazySingleton<CacheHelper>(() => CacheHelper());
  getIt.registerLazySingleton<ApiConsumer>(() => DioConsumer(dio: Dio()));
  getIt.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(DataConnectionChecker()),
  );

  // -------- Auth --------
  getIt.registerLazySingleton<UserRepository>(
    () => UserRepository(
      api: getIt<ApiConsumer>(),
      networkInfo: getIt<NetworkInfo>(),
    ),
  );
  getIt.registerFactory<UserCubit>(
    () => UserCubit(getIt<UserRepository>()),
  );

  // -------- Company --------

  // 1. Data sources
  getIt.registerLazySingleton<CompanyRemoteDataSource>(
    () => CompanyRemoteDataSource(getIt<ApiConsumer>()),
  );
  getIt.registerLazySingleton<CompanyLocalDataSource>(
    () => CompanyLocalDataSource(getIt<CacheHelper>()),
  );

  // 2. Repository
  getIt.registerLazySingleton<CompanyRepository>(
    () => CompanyRepositoryImpl(
      networkInfo: getIt<NetworkInfo>(),
      remoteDataSource: getIt<CompanyRemoteDataSource>(),
      localDataSource: getIt<CompanyLocalDataSource>(),
    ),
  );

  // 3. Use case
  getIt.registerLazySingleton<GetCompanies>(
    () => GetCompanies(getIt<CompanyRepository>()),
  );

  // 4. Cubit
  getIt.registerLazySingleton<CompanyCubit>(
    () => CompanyCubit(getCompanies: getIt<GetCompanies>()),
  );

  // -------- Invoice --------

  // 1. Data sources
  getIt.registerLazySingleton<InvoiceLocalDataSource>(
    () => InvoiceLocalDataSource(),
  );
  getIt.registerLazySingleton<InvoiceRemoteDataSource>(
    () => InvoiceRemoteDataSource(getIt<ApiConsumer>()),
  );

  // 2. Repository
  getIt.registerLazySingleton<InvoiceRepository>(
    () => InvoiceRepositoryImpl(
      networkInfo: getIt<NetworkInfo>(),
      remoteDataSource: getIt<InvoiceRemoteDataSource>(),
      localDataSource: getIt<InvoiceLocalDataSource>(),
    ),
  );

  // 3. Use cases
  getIt.registerLazySingleton<GetInvoices>(
    () => GetInvoices(getIt<InvoiceRepository>()),
  );
  getIt.registerLazySingleton<VerifyInvoice>(
    () => VerifyInvoice(getIt<InvoiceRepository>()),
  );

  // 4. Cubit
  getIt.registerLazySingleton<InvoiceCubit>(
    () => InvoiceCubit(
      getInvoices: getIt<GetInvoices>(),
      verifyInvoiceUseCase: getIt<VerifyInvoice>(),
    ),
  );
}




// final getIt = GetIt.instance;

// void setupServiceLocator() {
//   // CORE
//   getIt.registerLazySingleton<CacheHelper>(() => CacheHelper());
//   getIt.registerLazySingleton<ApiConsumer>(() => DioConsumer(dio: Dio()));
//   getIt.registerLazySingleton<NetworkInfo>(
//     () => NetworkInfoImpl(DataConnectionChecker()),
//   );

//   // Auth
//   getIt.registerLazySingleton<UserRepository>(
//     () => UserRepository(api: getIt(), networkInfo: getIt()),
//   );
//   getIt.registerFactory<UserCubit>(() => UserCubit(getIt()));

//   // Company
//   getIt.registerLazySingleton<CompanyRemoteDataSource>(
//     () => CompanyRemoteDataSource(getIt()),
//   );
//   getIt.registerLazySingleton<CompanyLocalDataSource>(
//     () => CompanyLocalDataSource(getIt()),
//   );
//   getIt.registerLazySingleton<CompanyRepository>(
//     () => CompanyRepositoryImpl(
//       networkInfo: getIt(),
//       remoteDataSource: getIt(),
//       localDataSource: getIt(),
//     ),
//   );
//   getIt.registerLazySingleton<GetCompanies>(
//     () => GetCompanies(getIt()),
//   );
//   getIt.registerFactory<CompanyCubit>(
//     () => CompanyCubit(getCompanies: getIt()),
//   );

//   // Invoice
//   getIt.registerLazySingleton<InvoiceLocalDataSource>(
//     () => InvoiceLocalDataSource(),
//   );
//   getIt.registerLazySingleton<InvoiceRemoteDataSource>(
//     () => InvoiceRemoteDataSource(getIt()),
//   );
//   getIt.registerLazySingleton<InvoiceRepository>(
//     () => InvoiceRepositoryImpl(
//       networkInfo: getIt(),
//       remoteDataSource: getIt(),
//       localDataSource: getIt(),
//     ),
//   );
//   getIt.registerLazySingleton<GetInvoices>(
//     () => GetInvoices(getIt()),
//   );
//   getIt.registerLazySingleton<VerifyInvoice>(
//     () => VerifyInvoice(getIt()),
//   );
//   getIt.registerFactory<InvoiceCubit>(
//     () => InvoiceCubit(
//       getInvoices: getIt(),
//       verifyInvoiceUseCase: getIt(),
//     ),
//   );
// }
