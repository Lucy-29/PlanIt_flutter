// import 'package:ems_1/core/service_locator/service_locator.dart';
// import 'package:ems_1/features/auth/presentation/screens/login_page.dart';
// import 'package:ems_1/features/home/presentation/screens/user_home_screen.dart';
// import 'package:ems_1/features/home/presentation/screens/user_screens.dart';
// import 'package:ems_1/features/splashscreens/screens/splash_screens.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:ems_1/features/auth/domain/repositories/auth_repository.dart';
// import 'package:ems_1/features/auth/presentation/cubit/auth/auth_cubit.dart';
// import 'package:ems_1/core/themes/app_themes.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   setupServiceLocator();

//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => AuthCubit(sl<AuthRepository>()),
//       child: MaterialApp(
//         theme: AppThemes().lightTheme,
//         title: 'PLANIT',
//         debugShowCheckedModeBanner: false,
//         home: BlocBuilder<AuthCubit, AuthState>(
//           builder: (context, state) {
//             // While the AuthCubit is checking the token, show a splash screen.
//             // if (state is AuthInitial || state is AuthLoading) {
//             //   return const SplashScreens();
//             // }

//             // if (state is Authenticated) {
//             //   return const HomeScreen();
//             // }
//             return UserScreens();
//           },
//         ),
//       ),
//     );
//   }
// }
import 'package:ems_1/core/service_locator/service_locator.dart';
import 'package:ems_1/features/home/presentation/cubit/themes/themes_cubit.dart'; // Correct import
import 'package:ems_1/features/home/presentation/screens/user_screens.dart';
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
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthCubit(sl<AuthRepository>()),
        ),
        BlocProvider(
          create: (context) => ThemeCubit(),
        ),
      ],
      child: BlocBuilder<ThemeCubit, ThemesState>(
        builder: (context, state) {
          return MaterialApp(
            title: 'PLANIT',
            debugShowCheckedModeBanner: false,
            theme: AppThemes().lightTheme,
            darkTheme: AppThemes().darkTheme,
            themeMode: state is ThemesDark ? ThemeMode.dark : ThemeMode.light,
            home: BlocBuilder<AuthCubit, AuthState>(
              builder: (context, authState) {
                // While the AuthCubit is checking the token, show a splash screen.
                // if (state is AuthInitial || state is AuthLoading) {
                //   return const SplashScreens();
                // }

                // if (state is Authenticated) {
                //   return const HomeScreen();
                // }
                return UserScreens();
              },
            ),
          );
        },
      ),
    );
  }
}
