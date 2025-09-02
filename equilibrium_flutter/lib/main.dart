import 'package:equilibrium_flutter/HubConnectionHandler.dart';
import 'package:equilibrium_flutter/views/connect_hub/connect_screen.dart';
import 'package:equilibrium_flutter/views/devices/device_detail_screen.dart';
import 'package:equilibrium_flutter/views/devices/device_list.dart';
import 'package:equilibrium_flutter/views/scenes/scene_list.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:get_it/get_it.dart';

Future<void> main() async {
  // TODO: Is this good practice?
  GetIt locator = GetIt.instance;
  locator.registerSingleton<HubConnectionHandler>(HubConnectionHandler());

  runApp(StatefulShellRouteExampleApp());
}

class ScaffoldBottomNavigationBar extends StatelessWidget {
  const ScaffoldBottomNavigationBar({required this.navigationShell, Key? key})
    : super(key: key ?? const ValueKey<String>('ScaffoldBottomNavigationBar'));

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.tv_outlined),
            label: 'Scenes',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.devices), label: 'Devices'),
        ],
        currentIndex: navigationShell.currentIndex,
        onTap: (int tappedIndex) {
          navigationShell.goBranch(tappedIndex);
        },
      ),
    );
  }
}

class StatefulShellRouteExampleApp extends StatelessWidget {
  StatefulShellRouteExampleApp({super.key});

  final GoRouter _router = GoRouter(
    initialLocation: '/connect',
    routes: <RouteBase>[
      GoRoute(
        path: '/connect',
        builder: (BuildContext context, GoRouterState state) {
          return ConnectScreen();
        },
      ),
      StatefulShellRoute.indexedStack(
        builder: (
          BuildContext context,
          GoRouterState state,
          StatefulNavigationShell navigationShell,
        ) {
          return ScaffoldBottomNavigationBar(navigationShell: navigationShell);
        },
        branches: <StatefulShellBranch>[
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: '/scenes',
                builder: (BuildContext context, GoRouterState state) {
                  return const SceneList();
                },
                routes: <RouteBase>[
                  GoRoute(
                    path: "/:sceneId",
                    builder:
                        (context, state) => DeviceDetailScreen(
                          deviceId: int.parse(state.pathParameters['sceneId']!),
                        ),
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: '/devices',
                builder: (BuildContext context, GoRouterState state) {
                  return const DeviceList();
                },
                routes: <RouteBase>[
                  GoRoute(
                    path: "/:deviceId",
                    builder:
                        (context, state) => DeviceDetailScreen(
                          deviceId: int.parse(
                            state.pathParameters['deviceId']!,
                          ),
                        ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ],
    redirect: (context, state) {},
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Equilibrium',
      theme: ThemeData(primarySwatch: Colors.orange),
      routerConfig: _router,
    );
  }
}

class RootScreen extends StatelessWidget {
  const RootScreen({required this.label, required this.detailsPath, super.key});

  final String label;
  final String detailsPath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Root of section $label')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              'Screen $label',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const Padding(padding: EdgeInsets.all(4)),
            TextButton(
              onPressed: () {
                GoRouter.of(context).go(detailsPath);
              },
              child: const Text('View details'),
            ),
            const Padding(padding: EdgeInsets.all(4)),
            TextButton(
              onPressed: () {
                GoRouter.of(context).go('/connect');
              },
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({required this.label, super.key});

  final String label;

  @override
  State<StatefulWidget> createState() => DetailsScreenState();
}

class DetailsScreenState extends State<DetailsScreen> {
  int _counter = 0;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Details Screen - ${widget.label}')),
      body: _build(context),
    );
  }

  Widget _build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            'Details for ${widget.label} - Counter: $_counter',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const Padding(padding: EdgeInsets.all(4)),
          TextButton(
            onPressed: () {
              setState(() {
                _counter++;
              });
            },
            child: const Text('Increment counter'),
          ),
          const Padding(padding: EdgeInsets.all(8)),
          const Padding(padding: EdgeInsets.all(4)),
          TextButton(
            onPressed: () {
              GoRouter.of(context).go('/connect');
            },
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}
