import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paises_api/blocs/pais_detalle_bloc/pais_detalle_bloc.dart';
import 'package:paises_api/screens/details_screen.dart';
import 'package:paises_api/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const HomeScreen();
      },
      routes: <RouteBase>[
        // como es hija de '/', la ruta completa queda /country/:code
        GoRoute(
          path: 'country/:code',
          builder: (BuildContext context, GoRouterState state) {
            // saco el codigo de la url, ej: /country/COL -> COL
            final code = state.pathParameters['code']!;

            // cada pantalla de detalle tiene su propio bloc, asi si voy de
            // Colombia a Brasil (por las fronteras) cada una tiene su estado
            return BlocProvider(
              create: (context) =>
                  PaisDetalleBloc()..add(CargarPaisDetalleEvent(codigo: code)),
              child: DetailsScreen(code: code),
            );
          },
        ),
      ],
    ),
  ],
);
