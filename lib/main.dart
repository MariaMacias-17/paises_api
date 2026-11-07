import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paises_api/blocs/paises_bloc/paises_bloc.dart';
import 'package:paises_api/config/app_theme.dart';
import 'package:paises_api/config/routes.dart';

void main() {
  // el bloc de la lista va arriba de todo para que no se pierda la pagina
  // cuando entro al detalle y vuelvo
  runApp(BlocProvider(create: (context) => PaisesBloc(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      title: 'Paises App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.oscuro,
    );
  }
}
