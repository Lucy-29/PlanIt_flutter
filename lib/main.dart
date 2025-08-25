import 'package:ems_1/core/service_locator/service_locator.dart';
import 'package:ems_1/features/auth/presentation/screens/login_page.dart';
import 'package:ems_1/features/company/presentation/screens/company_events_screen.dart';
import 'package:ems_1/features/company/presentation/cubit/profile/company_profile_cubit.dart';
import 'package:ems_1/features/company/presentation/cubit/events/company_events_cubit.dart';
import 'package:ems_1/features/company/presentation/cubit/gallery/company_gallery_cubit.dart';
import 'package:ems_1/features/company/presentation/cubit/statistics/company_statistics_cubit.dart';
import 'package:ems_1/features/company/presentation/screens/company_gallery_screen.dart';
import 'package:ems_1/features/company/presentation/screens/company_profile_screen.dart';
import 'package:ems_1/features/company/presentation/screens/company_statistics_screen.dart';
import 'package:ems_1/features/home/domain/repositories/event_repository.dart';
import 'package:ems_1/features/home/presentation/cubit/my_event/my_event_cubit.dart';
import 'package:ems_1/features/home/presentation/cubit/themes/themes_cubit.dart';
import 'package:ems_1/features/home/presentation/screens/user_screens.dart';
import 'package:ems_1/features/company/presentation/screens/company_screens.dart';
import 'package:ems_1/features/splashscreens/presentation/cubit/splashscreen_cubit/splash_screen_cubit.dart';
import 'package:ems_1/features/splashscreens/presentation/screens/splash_screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ems_1/features/auth/domain/repositories/auth_repository.dart';
import 'package:ems_1/features/auth/presentation/cubit/auth/auth_cubit.dart';
import 'package:ems_1/core/themes/app_themes.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';
import 'package:ems_1/features/home/presentation/screens/favorite/Fav_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupServiceLocator();
  runApp(
    ChangeNotifierProvider(
      create: (_) => FavoritesProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit(sl<AuthRepository>())),
        BlocProvider(create: (context) => SplashScreenCubit()),
        BlocProvider(create: (context) => ThemesCubit()),
        BlocProvider(create: (context) => MyEventCubit(sl<EventRepository>())),
        BlocProvider(create: (context) => sl<CompanyProfileCubit>()),
        BlocProvider(create: (context) => sl<CompanyEventsCubit>()),
        BlocProvider(create: (context) => sl<CompanyGalleryCubit>()),
        BlocProvider(create: (context) => sl<CompanyStatisticsCubit>()),
      ],
      child: BlocBuilder<ThemesCubit, ThemesState>(
        builder: (context, state) {
          return MaterialApp(
            title: 'PLANIT',
            debugShowCheckedModeBanner: false,
            theme: AppThemes().lightTheme,
            darkTheme: AppThemes().darkTheme,
            themeMode: state is ThemesDark ? ThemeMode.dark : ThemeMode.light,
            home: const AppRouter(),
          );
        },
      ),
    );
  }
}

class AppRouter extends StatefulWidget {
  const AppRouter({super.key});

  @override
  State<AppRouter> createState() => _AppRouterState();
}

class _AppRouterState extends State<AppRouter> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SplashScreenCubit>().checkIfFirstTime();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SplashScreenCubit, SplashScreenState>(
      builder: (context, state) {
        if (state is SplashScreenInProgress) {
          return const SplashScreens();
        }
        if (state is SplashScreenComplete) {
          return BlocBuilder<AuthCubit, AuthState>(
            builder: (context, authState) {
              if (authState is Authenticated) {
                if (authState.user.type == 'provider') {
                  return CompanyScreens();
                } else if (authState.user.type == 'company') {
                  return const CompanyScreens();
                } else {
                  return const UserScreens();
                }
              } else {
                return const LoginPage();
              }
            },
          );
        }

        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      },
    );
  }
}
