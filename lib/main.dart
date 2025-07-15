import 'package:ems_1/core/service_locator/service_locator.dart';
import 'package:ems_1/features/auth/presentation/screens/login_page.dart';
<<<<<<< HEAD
import 'package:ems_1/features/home/presentation/screens/user_screens.dart';
import 'package:ems_1/features/provider/Provider_Screens/offers/offers_screen.dart';
=======
import 'package:ems_1/features/home/presentation/cubit/themes/themes_cubit.dart';
import 'package:ems_1/features/home/presentation/screens/user_screens.dart';
import 'package:ems_1/features/splashscreens/presentation/cubit/splashscreen_cubit/splash_screen_cubit.dart';
import 'package:ems_1/features/splashscreens/presentation/screens/splash_screens.dart';
>>>>>>> 315046e6be2da8458c26a0121f0d02d6c66c4b2e
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ems_1/features/auth/domain/repositories/auth_repository.dart';
import 'package:ems_1/features/auth/presentation/cubit/auth/auth_cubit.dart';
import 'package:ems_1/core/themes/app_themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupServiceLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    return BlocProvider(
      create: (context) => AuthCubit(sl<AuthRepository>()),
      child: MaterialApp(
        // theme: AppThemes().lightTheme,
        theme: AppThemes().darkTheme,
        title: 'PLANIT',
        debugShowCheckedModeBanner: false,
        home: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            // While the AuthCubit is checking the token, show a splash screen.
            // if (state is AuthInitial || state is AuthLoading) {
            //   return const SplashScreens();
            // }

            // if (state is Authenticated) {
            //   return const HomeScreen();
            // }
            return LoginPage();
          },
        ),
=======
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit(sl<AuthRepository>())),
        BlocProvider(create: (context) => SplashScreenCubit()),
        BlocProvider(create: (context) => ThemesCubit()),
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
>>>>>>> 315046e6be2da8458c26a0121f0d02d6c66c4b2e
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
                return const UserScreens();
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
