import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finpro/features/auth/data/firebase_auth_repo.dart';
import 'package:finpro/features/auth/presentation/cubits/auth.cubit.dart';
import 'package:finpro/features/auth/presentation/cubits/auth_states.dart';
import 'package:finpro/features/auth/presentation/pages/auth_pages.dart';
import 'package:finpro/features/health/domain/repos/health_calculator_repo.dart';
import 'package:finpro/features/health/presentation/cubits/health_cubit.dart';
import 'package:finpro/features/home/presentation/pages/home_pages.dart';
import 'package:finpro/features/menu%20makanan/presentation/models/restaurant.dart';

import 'package:finpro/themes/light_mode.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
  // Import Firestore

class MyApp extends StatelessWidget {
  final authRepo = FirebaseAuthRepo();

  MyApp({super.key});



  @override
  Widget build(BuildContext context) {
    // Membuat instance HealthCalculatorRepo
    final healthCalculatorRepo = HealthCalculatorRepo();


    // Provide cubit to app
    return MultiBlocProvider(
      providers: [
        // Provider untuk AuthCubit
        BlocProvider(
          create: (context) => AuthCubit(authRepo: authRepo)..checkAuth(),
        ),
        // Provider untuk HealthCubit
        BlocProvider<HealthCubit>(
          create: (context) => HealthCubit(
            healthCalculatorRepo,            // Instance dari HealthCalculatorRepo
            FirebaseFirestore.instance,      // Instance Firestore
          ),
        ),
        ChangeNotifierProvider(
      create: (context) => Restaurant(),
        ),
      ],
  

      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightMode,
        home: BlocConsumer<AuthCubit, AuthState>(
          builder: (context, authState) {
            print(authState);
            
            if (authState is Unauthenticated) {
              return const AuthPages();
            }

            if (authState is Authenticated) {
              return const HomePages();
            }

            // Loading state
            else {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            }
          },

          listener: (context, state) {
            if (state is AuthError) {
              ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
        ),
      ),
    );
  }
}
