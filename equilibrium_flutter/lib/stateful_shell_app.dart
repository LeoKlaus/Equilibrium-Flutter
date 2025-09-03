import 'package:equilibrium_flutter/bottom_bar.dart';
import 'package:equilibrium_flutter/views/bluetooth_devices/bluetooth_device_list.dart';
import 'package:equilibrium_flutter/views/connect_hub/connect_screen.dart';
import 'package:equilibrium_flutter/views/devices/device_detail_screen.dart';
import 'package:equilibrium_flutter/views/devices/device_list.dart';
import 'package:equilibrium_flutter/views/icons/icon_list.dart';
import 'package:equilibrium_flutter/views/more/more_screen.dart';
import 'package:equilibrium_flutter/views/scenes/scene_detail_screen.dart';
import 'package:equilibrium_flutter/views/scenes/scene_list.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import 'helpers/hub_connection_handler.dart';

class StatefulShellApp extends StatelessWidget {
  StatefulShellApp({super.key});

  final HubConnectionHandler connectionHandler =
      GetIt.instance<HubConnectionHandler>();

  late final GoRouter _router = GoRouter(
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
          return BottomBar(navigationShell: navigationShell);
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
                        (context, state) => SceneDetailScreen(
                          sceneId: int.parse(state.pathParameters['sceneId']!),
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
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: '/more',
                builder: (BuildContext context, GoRouterState state) {
                  return const MoreScreen();
                },
                routes: <RouteBase>[
                  GoRoute(
                    path: "/images",
                    builder: (context, state) => const IconList(),
                  ),
                  GoRoute(
                    path: "/bluetooth_devices",
                    builder: (context, state) => const BluetoothDeviceList(),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ],
    redirect: (context, state) {
      if (state.uri.path == "/") {
        if (connectionHandler.api != null) {
          return "/scenes";
        } else {
          return "/connect";
        }
      } else {
        return null;
      }
    },
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Equilibrium',
      theme: ThemeData(brightness: Brightness.light),
      darkTheme: ThemeData(brightness: Brightness.dark),
      routerConfig: _router,
    );
  }
}
