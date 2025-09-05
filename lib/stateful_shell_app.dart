import 'package:dynamic_color/dynamic_color.dart';
import 'package:equilibrium_flutter/bottom_bar.dart';
import 'package:equilibrium_flutter/themes/dark.dart';
import 'package:equilibrium_flutter/themes/light.dart';
import 'package:equilibrium_flutter/views/bluetooth_devices/bluetooth_device_list.dart';
import 'package:equilibrium_flutter/views/commands/command_list.dart';
import 'package:equilibrium_flutter/views/commands/create_command_screen.dart';
import 'package:equilibrium_flutter/views/connect_hub/connect_screen.dart';
import 'package:equilibrium_flutter/views/devices/device_detail_screen.dart';
import 'package:equilibrium_flutter/views/devices/device_list.dart';
import 'package:equilibrium_flutter/views/icons/icon_list.dart';
import 'package:equilibrium_flutter/views/macros/create_macro_screen.dart';
import 'package:equilibrium_flutter/views/macros/macro_list.dart';
import 'package:equilibrium_flutter/views/more/more_screen.dart';
import 'package:equilibrium_flutter/views/scenes/scene_detail_screen.dart';
import 'package:equilibrium_flutter/views/scenes/scene_list.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:equilibrium_flutter/models/classes/macro.dart';

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
        builder:
            (
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
                    builder: (context, state) => SceneDetailScreen(
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
                    builder: (context, state) => DeviceDetailScreen(
                      deviceId: int.parse(state.pathParameters['deviceId']!),
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
                  return MoreScreen();
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
                  GoRoute(
                    path: "/commands",
                    builder: (context, state) => const CommandList(),
                    routes: <RouteBase>[
                      GoRoute(
                        path: "/create",
                        builder: (context, state) {
                          if (state.extra != null) {
                            return CreateCommandScreen(
                              reloadParent: state.extra as Function,
                            );
                          } else {
                            return CreateCommandScreen(reloadParent: () {});
                          }
                        },
                      ),
                    ],
                  ),
                  GoRoute(
                    path: "/macros",
                    builder: (context, state) => const MacroList(),
                    routes: <RouteBase>[
                      GoRoute(
                        path: "/create",
                        builder: (context, state) {
                          if (state.extra != null) {
                            return CreateMacroScreen(
                              reloadParent: state.extra as Function,
                            );
                          } else {
                            return CreateMacroScreen(reloadParent: () {});
                          }
                        },
                      ),
                      GoRoute(
                        path: '/edit',
                        builder: (context, state) {
                          if (state.extra != null) {
                            final (macroToEdit, reloadParent) =
                                state.extra as (Macro, Function);
                            return CreateMacroScreen(
                              macroToEdit: macroToEdit,
                              reloadParent: reloadParent,
                            );
                          } else {
                            return CreateMacroScreen(reloadParent: () {});
                          }
                        },
                      ),
                    ],
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
    return DynamicColorBuilder(
      builder: (lightColorScheme, darkColorScheme) {
        return MaterialApp.router(
          title: 'Equilibrium',
          theme: lightColorScheme != null
              ? ThemeData(colorScheme: lightColorScheme, useMaterial3: true)
              : lightTheme,
          darkTheme: darkColorScheme != null
              ? ThemeData(colorScheme: darkColorScheme, useMaterial3: true)
              : darkTheme,
          themeMode: ThemeMode.system,
          routerConfig: _router,
        );
      },
    );
  }
}
