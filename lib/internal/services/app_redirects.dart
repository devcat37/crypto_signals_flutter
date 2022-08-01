import 'package:crypto_signals_july/internal/pages/workspace.dart';
import 'package:flutter/material.dart';

void pop(BuildContext context) => Navigator.of(context).pop();

/// Переход на главную страницу.
void replaceWithWorkspace(BuildContext context) => Navigator.of(context).pushReplacementNamed(Workspace.routeName);
