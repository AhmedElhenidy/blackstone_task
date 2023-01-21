import 'package:blackstone_task/app/utils/navigation_helper.dart';
import 'package:blackstone_task/presentation/presentation_logic_holder/currency_cubit.dart';
import 'package:blackstone_task/presentation/views/main_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app/utils/get_it_injection.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  await initInjection();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<CurrencyCubit>(
          create: (BuildContext context) => CurrencyCubit(),
        ),
      ],
      child: EasyLocalization(
        supportedLocales: const[
          Locale('en', 'US'), // Arabic
        ],
        path: 'assets/lang',
        saveLocale: true,
        startLocale:  const Locale('en', 'US'),
        fallbackLocale: const Locale('en', 'US'),
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'currency App',
          themeMode: ThemeMode.dark,
          navigatorKey: getIt<NavHelper>().navigatorKey,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          localizationsDelegates: context.localizationDelegates,
          home: CurrencyView()
        ),
      ),
    );
  }
}

