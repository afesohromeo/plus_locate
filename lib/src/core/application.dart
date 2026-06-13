import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plus_locate/src/domain/domain.dart';
import 'package:plus_locate/src/features/features.dart';
import 'package:provider/provider.dart';

import 'core.dart';

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (_) => PlusCodeRepository()),
        RepositoryProvider(create: (_) => GeocodingRepository()),
        RepositoryProvider(create: (_) => SavedCodesRepository()),
        RepositoryProvider(create: (_) => SearchQuotaRepository()),
        Provider<RouteManager>(
          lazy: true,
          create: (context) => RouteManager(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => HomeBloc()),
          BlocProvider(
            create: (context) => GenerateBloc(
              repository: context.read<PlusCodeRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => SearchBloc(
              plusCodeRepository: context.read<PlusCodeRepository>(),
              geocodingRepository: context.read<GeocodingRepository>(),
              quotaRepository: context.read<SearchQuotaRepository>(),
            )..add(const SearchEvent.init()),
          ),
          BlocProvider(
            create: (context) => MapViewBloc(
              geocodingRepository: context.read<GeocodingRepository>(),
              plusCodeRepository: context.read<PlusCodeRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => HistoryBloc(
              repository: context.read<SavedCodesRepository>(),
            )..add(const HistoryEvent.init()),
          ),
        ],
        child: const ApplicationView(),
      ),
    );
  }
}
