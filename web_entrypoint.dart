// lib/
// ├── core/
// │   ├── api/
// │   │   └── dio_client.dart
// │   ├── di/
// │   │   └── service_locator.dart
// │   └── storage/
// │       └── secure_storage_service.dart
// │
// ├── features/
// │   └── auth/
// │       ├── data/
// │       │   ├── datasources/
// │       │   │   └── auth_api_datasource.dart
// │       │   ├── models/
// │       │   │   ├── approval_status_model.dart
// │       │   │   ├── login_response_model.dart
// │       │   │   ├── provider_request_model.dart
// │       │   │   └── user_model.dart
// │       │   └── repositories/
// │       │       └── auth_repository_impl.dart
// │       │
// │       ├── domain/
// │       │   └── repositories/
// │       │       └── auth_repository.dart
// │       │
// │       └── presentation/
// │           ├── cubit/
// │           │   ├── approval/
// │           │   │   ├── approval_cubit.dart
// │           │   │   └── approval_state.dart
// │           │   ├── auth/
// │           │   │   ├── auth_cubit.dart
// │           │   │   └── auth_state.dart
// │           │   ├── login/
// │           │   │   ├── login_cubit.dart
// │           │   │   └── login_state.dart
// │           │   └── registration/
// │           │       ├── registration_cubit.dart
// │           │       └── registration_state.dart
// │           │
// │           └── screens/
// │               ├── home_screen.dart
// │               ├── login_screen.dart........
// │               ├── pending_approval_screen.dart
// │               ├── register_options_screen.dart..............
// │               ├── register_screen.dart
// │               └── splash_screen.dart
// │
// └── main.dart
// 
// 
// 
// features/
// ├── auth/
// │   └── presentation/
// │       └── screens/
// │           ├── login_screen.dart..........
// │           ├── pending_approval_screen.dart
// │           ├── register_options_screen.dart.................
// │           ├── register_screen.dart
// │           └── splash_screen.dart
// ├── home/
// │   └── presentation/
// │       └── screens/
// │           └── home_screen.dart  // The main dashboard for all logged-in users
// ├── profile/
// │   └── presentation/
// │       └── screens/
// │           └── profile_screen.dart // A single profile screen for all users
// └── settings/
//     └── presentation/
//         └── screens/
//             └── settings_screen.dart // A single settings screen for all users

//------------------------------------------------///////////////////////



// ib/features/home/presentation/
// ├── screens/
// │   ├── home_screen.dart           // <-- The smart router/dispatcher
// │   ├── user_home_page.dart        // <-- Your UI for a normal user
// │   ├── provider_home_page.dart    // <-- Your UI for a provider
// │   └── company_home_page.dart     // <-- Your UI for a company
// └── widgets/
//     └── ... (Widgets used by any of the 3 pages) ...
