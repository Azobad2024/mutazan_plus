import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void customNavigat(BuildContext context, String path, {Object? extra}) {
  GoRouter.of(context).push(path, extra: extra);
}

void customReplacementNavigate(BuildContext context, String path, {Object? extra}) {
  GoRouter.of(context).pushReplacement(path, extra: extra);
}

void customReplacementNavigateAll(BuildContext context, String path, {Object? extra}) {
  GoRouter.of(context).go(path, extra: extra);
}
