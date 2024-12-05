import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:uas_katalog_produk/firebase_options.dart';  // Pastikan file ini ada
import 'package:uas_katalog_produk/presentation/pages/login.dart';
import 'package:uas_katalog_produk/presentation/pages/products.dart';
import 'package:uas_katalog_produk/presentation/provider/cart/bloc/cart_bloc.dart';
import 'package:uas_katalog_produk/presentation/provider/login/bloc/login_bloc.dart';
import 'package:uas_katalog_produk/presentation/provider/product/bloc/product_bloc.dart';
import 'package:uas_katalog_produk/theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inisialisasi Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,  // Pastikan opsi ini sesuai dengan platform
  );

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getTemporaryDirectory(),
  );

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginBloc(),
        ),
        BlocProvider(
          create: (context) => ProductBloc()..add(LoadProducts()),
        ),
        BlocProvider(
          create: (context) => CartBloc(),
        ),
      ],
      child: MaterialApp(
        theme: const MaterialTheme().theme(MaterialTheme.lightScheme()),
        home: BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state) {
            if (state.isLoggedIn) {
              return ProductsPage();
            } else {
              return LoginPage();
            }
          },
        ),
      ),
    );
  }
}
