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
  getIt.registerLazySingleton<CompanyRemoteDataSource>(
    () => CompanyRemoteDataSource(getIt<ApiConsumer>()),
  );
  getIt.registerLazySingleton<CompanyLocalDataSource>(
    () => CompanyLocalDataSource(getIt<CacheHelper>()),
  );
  getIt.registerLazySingleton<CompanyRepository>(
    () => CompanyRepositoryImpl(
      networkInfo: getIt<NetworkInfo>(),
      remoteDataSource: getIt<CompanyRemoteDataSource>(),
      localDataSource: getIt<CompanyLocalDataSource>(),
    ),
  );
  getIt.registerLazySingleton<GetCompanies>(
    () => GetCompanies(getIt<CompanyRepository>()),
  );
  getIt.registerFactory<CompanyCubit>(
    () => CompanyCubit(getCompanies: getIt<GetCompanies>()),
  );

  // -------- Invoice --------
  // 1. Local data source
  getIt.registerLazySingleton<InvoiceLocalDataSource>(
    () => InvoiceLocalDataSource(),
  );
  // 2. Remote data source
  getIt.registerLazySingleton<InvoiceRemoteDataSource>(
    () => InvoiceRemoteDataSource(getIt<ApiConsumer>()),
  );
  // 3. Repository
  getIt.registerLazySingleton<InvoiceRepository>(
    () => InvoiceRepositoryImpl(
      networkInfo: getIt<NetworkInfo>(),
      remoteDataSource: getIt<InvoiceRemoteDataSource>(),
      localDataSource: getIt<InvoiceLocalDataSource>(),
    ),
  );
  // 4. Use cases
  getIt.registerLazySingleton<GetInvoices>(
    () => GetInvoices(getIt<InvoiceRepository>()),
  );
  getIt.registerLazySingleton<VerifyInvoice>(
    () => VerifyInvoice(getIt<InvoiceRepository>()),
  );
  // 5. Cubit
  getIt.registerFactory<InvoiceCubit>(
    () => InvoiceCubit(
      getInvoices: getIt<GetInvoices>(),
      verifyInvoiceUseCase: getIt<VerifyInvoice>(),
    ),
  );
}
