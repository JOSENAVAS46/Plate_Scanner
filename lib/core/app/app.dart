import 'package:plate_scanner_app/core/cache/cache_app.dart';
import 'package:plate_scanner_app/core/routes/routes.dart';
import 'package:plate_scanner_app/core/settings/app_theme.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:plate_scanner_app/features/history/presentation/blocs/history_bloc.dart';
import 'package:plate_scanner_app/features/identification/data/repositories/identification_repository.dart';
import 'package:plate_scanner_app/features/identification/domain/usecases/identification_use_case.dart';
import 'package:plate_scanner_app/features/identification/presentation/blocs/identification_bloc.dart';
import 'package:plate_scanner_app/features/input_plate/data/repositories/input_plate_repository.dart';
import 'package:plate_scanner_app/features/input_plate/domain/usecases/input_plate_use_case.dart';
import 'package:plate_scanner_app/features/input_plate/presentation/blocs/input_plate_bloc.dart';
import 'package:plate_scanner_app/features/reports/data/repositories/reports_repository.dart';
import 'package:plate_scanner_app/features/reports/domain/usecases/reports_use_case.dart';
import 'package:plate_scanner_app/features/reports/presentation/blocs/reports_bloc.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  final cache = CacheApp();

  @override
  Widget build(BuildContext context) {
    // Widget base que contendrá toda la app
    final materialApp = MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('es'), Locale('en')],
      theme: AppTheme().getTheme(),
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.initialRoute,
      onGenerateRoute: Routes.routeSettings,

      /*
      builder: (context, child) {
        return HandleNotificationInteractions(child: child!);
      },
      */
    );

    // Cuando no hay providers, retornamos directamente el MaterialApp
    // return materialApp;

    // Cuando añadas tus providers en el futuro, puedes cambiar a:

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<ReportsRepository>(
          create: (_) => ReportsUseCase(),
        ),
        RepositoryProvider<IdentificationRepository>(
            create: (_) => IdentificationUseCase()),
        RepositoryProvider<InputPlateRepository>(
            create: (_) => InputPlateUseCase()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => ReportsBloc(
              repository: RepositoryProvider.of<ReportsRepository>(context),
            ),
          ),
          BlocProvider(
              create: (context) => IdentificationBloc(
                  repository: RepositoryProvider.of<IdentificationRepository>(
                      context))),
          BlocProvider(
              create: (context) => InputPlateBloc(
                  repository:
                      RepositoryProvider.of<InputPlateRepository>(context))),
          BlocProvider(create: (context) => HistoryBloc()),
        ],
        child: materialApp,
      ),
    );
  }
}

class HandleNotificationInteractions extends StatefulWidget {
  final Widget child;
  const HandleNotificationInteractions({required this.child});

  @override
  State<HandleNotificationInteractions> createState() =>
      _HandleNotificationInteractionsState();
}

class _HandleNotificationInteractionsState
    extends State<HandleNotificationInteractions> {
  Future<void> setupInteractedMessage() async {
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }

    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }

  void _handleMessage(RemoteMessage message) {
    /*
     context.read<NotificationBloc>().handleRemoteMessage(message);

    final messageId =
        message.messageId?.replaceAll(':', '').replaceAll('%', '');

    Navigator.pushNamedAndRemoveUntil(context, '/dashboard', (route) => true);
    */
  }

  @override
  void initState() {
    super.initState();
    setupInteractedMessage();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
